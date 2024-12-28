import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:famcards/core/common/widgets/loader.dart';
import 'package:famcards/features/cards/data/models/contextual_card_model.dart';
import 'package:famcards/features/cards/presentation/cubit/card_cubit.dart';
import 'package:famcards/features/cards/presentation/cubit/card_state.dart';
import 'package:famcards/features/cards/presentation/widgets/design_hc1_widget.dart';
import 'package:famcards/features/cards/presentation/widgets/design_hc3_widget.dart';
import 'package:famcards/features/cards/presentation/widgets/design_hc5_widget.dart';
import 'package:famcards/features/cards/presentation/widgets/design_hc6_widget.dart';
import 'package:famcards/features/cards/presentation/widgets/design_hc9_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/logo/fampaylogo.png'),
      ),
      body: BlocBuilder<CardCubit, CardState>(
        builder: (context, state) {
          if (state is CardInitial) {
            context.read<CardCubit>().clearAllRemindLaterCards();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Hey there!',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const Text(
                    'Press the button below to get started.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<CardCubit>().refreshCards();
                    },
                    child: const Text("Fetch Cards"),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/logo/fam_bird.png'),
                ],
              ),
            );
          } else if (state is CardLoading) {
            return const Loader();
          } else if (state is CardLoaded) {
            final hcGroups = state.cards.first.hcGroups;

            // Sort hcGroups based on the desired order of DesignTypes
            final sortedHcGroups = [
              ...hcGroups.where((group) => group.designType == DesignType.HC3),
              ...hcGroups.where((group) => group.designType == DesignType.HC6),
              ...hcGroups.where((group) => group.designType == DesignType.HC5),
              ...hcGroups.where((group) => group.designType == DesignType.HC9),
              ...hcGroups.where((group) => group.designType == DesignType.HC1),
            ];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RefreshIndicator.adaptive(
                onRefresh: () async {
                  await context.read<CardCubit>().refreshCards();
                },
                child: ListView.builder(
                  itemCount: sortedHcGroups.length,
                  itemBuilder: (context, index) {
                    final hcGroup = sortedHcGroups[index];
                    switch (hcGroup.designType) {
                      case DesignType.HC1:
                        return DesignHC1Widget(hcGroup: hcGroup);
                      case DesignType.HC3:
                        return DesignHC3Widget(hcGroup: hcGroup);
                      case DesignType.HC5:
                        return DesignHC5Widget(hcGroup: hcGroup);
                      case DesignType.HC6:
                        return DesignHC6Widget(hcGroup: hcGroup);
                      case DesignType.HC9:
                        return DesignHC9Widget(hcGroup: hcGroup);
                    }
                  },
                ),
              ),
            );
          } else if (state is NoCardsAvailable) {
            return const Center(
              child: Text('No more cards available.'),
            );
          } else if (state is CardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<CardCubit>().refreshCards();
                    },
                    child: const Text("Retry"),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/logo/fam_bird.png'),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }
        },
      ),
    );
  }
}
