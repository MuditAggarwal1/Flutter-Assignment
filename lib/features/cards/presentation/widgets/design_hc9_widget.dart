import 'package:famcards/core/utils/hex_to_gradient.dart';
import 'package:famcards/features/cards/data/models/card_model.dart' as card;
import 'package:famcards/features/cards/data/models/hc_group_model.dart';
import 'package:flutter/material.dart';

class DesignHC9Widget extends StatelessWidget {
  final HcGroup hcGroup;

  const DesignHC9Widget({super.key, required this.hcGroup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: SizedBox(
          height: hcGroup.height *
              1.3, // Increased height by 30% to make it look better
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hcGroup.cards.length,
            itemBuilder: (context, index) {
              final card = hcGroup.cards[index];
              return _buildHc9Card(context, card);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHc9Card(BuildContext context, card.Card card) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio: (card.bgImage?.aspectRatio ?? 1.5),
          child: Container(
            decoration: BoxDecoration(
              gradient: card.bgGradient != null
                  ? convertHexToGradient(card.bgGradient!)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
