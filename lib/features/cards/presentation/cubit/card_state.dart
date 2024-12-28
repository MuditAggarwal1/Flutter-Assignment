import 'package:equatable/equatable.dart';
import 'package:famcards/features/cards/data/models/contextual_card_model.dart';

// Abstract base state
abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object?> get props => [];
}

// Initial state
class CardInitial extends CardState {}

// Loading state
class CardLoading extends CardState {}

// Loaded state with a list of contextual cards
class CardLoaded extends CardState {
  final List<ContextualCards> cards;

  const CardLoaded({required this.cards});

  @override
  List<Object?> get props => [cards];
}

// Error state
class CardError extends CardState {
  final String message;

  const CardError({required this.message});

  @override
  List<Object?> get props => [message];
}

// No cards state (e.g., after all cards are dismissed)
class NoCardsAvailable extends CardState {}
