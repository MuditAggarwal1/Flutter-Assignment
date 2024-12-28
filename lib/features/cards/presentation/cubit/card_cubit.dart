import 'dart:developer';

import 'package:famcards/core/error/exceptions.dart';
import 'package:famcards/features/cards/data/datasources/card_local_data_source.dart';
import 'package:famcards/features/cards/data/datasources/card_remote_data_source.dart';
import 'package:famcards/features/cards/data/models/card_model.dart';
import 'package:famcards/features/cards/data/models/contextual_card_model.dart';
import 'package:famcards/features/cards/data/models/hc_group_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  final CardRemoteDataSource remoteDataSource;
  final CardLocalDataSource localDataSource;

  CardCubit({
    required this.remoteDataSource,
    required this.localDataSource,
  }) : super(CardInitial());

  // Fetch cards from remote data source
  Future<void> fetchCards() async {
    emit(CardLoading());
    try {
      final cards = await remoteDataSource.getCards();
      final dismissedCards = localDataSource.getDismissedCards();
      final remindLaterCards = localDataSource.getRemindLaterCards();

      // Filter out dismissed cards and remindLater cards from hcGroup cards
      List<ContextualCards> filteredCards = [];

      for (var contextualCard in cards) {
        // Filter the cards inside each hcGroup
        List<HcGroup> filteredHcGroups = [];

        for (var hcGroup in contextualCard.hcGroups) {
          // Filter cards in this HcGroup
          List<Card> filteredHcGroupCards = hcGroup.cards.where((card) {
            // Check if the card is neither dismissed nor set to remind later
            return !dismissedCards.contains(card.id.toString()) &&
                !remindLaterCards.contains(card.id.toString());
          }).toList();

          // Create a copy of the HcGroup with the filtered cards
          HcGroup updatedHcGroup =
              hcGroup.copyWith(cards: filteredHcGroupCards);

          // Add the updated HcGroup to the filtered list
          filteredHcGroups.add(updatedHcGroup);
        }

        // Create a copy of the ContextualCards with the updated hcGroups
        filteredCards.add(contextualCard.copyWith(hcGroups: filteredHcGroups));
      }

      if (filteredCards.isEmpty) {
        emit(NoCardsAvailable());
      } else {
        emit(CardLoaded(cards: filteredCards));
      }
    } on ServerException catch (e, stackTrace) {
      log("Error: ${e.toString()}, stackTrace: $stackTrace");
      emit(CardError(message: e.message));
    } catch (e, stackTrace) {
      log("Error: ${e.toString()}, stackTrace: $stackTrace");
      emit(CardError(message: e.toString()));
    }
  }

  // Handle "Dismiss Now" action (update local state only)
  Future<void> dismissCard(String cardId) async {
    // Save the card state as dismissed in local storage
    localDataSource.saveCardState(cardId: cardId, state: 'dismissed');

    // Get the current cards state (without fetching from API)
    final dismissedCards = localDataSource.getDismissedCards();
    final remindLaterCards = localDataSource.getRemindLaterCards();

    // Filter out dismissed and remindLater cards from local cards state
    final currentCards = await remoteDataSource.getCards();
    List<ContextualCards> filteredCards = [];

    for (var contextualCard in currentCards) {
      List<HcGroup> filteredHcGroups = [];

      for (var hcGroup in contextualCard.hcGroups) {
        List<Card> filteredHcGroupCards = hcGroup.cards.where((card) {
          return !dismissedCards.contains(card.id.toString()) &&
              !remindLaterCards.contains(card.id.toString());
        }).toList();

        HcGroup updatedHcGroup = hcGroup.copyWith(cards: filteredHcGroupCards);
        filteredHcGroups.add(updatedHcGroup);
      }

      filteredCards.add(contextualCard.copyWith(hcGroups: filteredHcGroups));
    }

    emit(CardLoaded(cards: filteredCards));
  }

  // Handle "Remind Later" action (update local state only)
  Future<void> remindLaterCard(String cardId) async {
    // Save the card state as remind later in local storage
    localDataSource.saveCardState(cardId: cardId, state: 'remind_later');

    // Get the current cards state (without fetching from API)
    final dismissedCards = localDataSource.getDismissedCards();
    final remindLaterCards = localDataSource.getRemindLaterCards();

    // Filter out dismissed and remindLater cards from local cards state
    final currentCards = await remoteDataSource.getCards();
    List<ContextualCards> filteredCards = [];

    for (var contextualCard in currentCards) {
      List<HcGroup> filteredHcGroups = [];

      for (var hcGroup in contextualCard.hcGroups) {
        List<Card> filteredHcGroupCards = hcGroup.cards.where((card) {
          return !dismissedCards.contains(card.id.toString()) &&
              !remindLaterCards.contains(card.id.toString());
        }).toList();

        HcGroup updatedHcGroup = hcGroup.copyWith(cards: filteredHcGroupCards);
        filteredHcGroups.add(updatedHcGroup);
      }

      filteredCards.add(contextualCard.copyWith(hcGroups: filteredHcGroups));
    }

    emit(CardLoaded(cards: filteredCards));
  }

  // Refresh cards (re-fetch from API)
  Future<void> refreshCards() async {
    await fetchCards();
  }

  Future<void> clearAllRemindLaterCards() async {
    await localDataSource.clearAllRemindLaterCards();
  }
}
