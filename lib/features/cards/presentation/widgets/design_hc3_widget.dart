import 'package:famcards/core/utils/hex_to_color.dart';
import 'package:famcards/core/utils/launch_url.dart';
import 'package:famcards/features/cards/data/models/card_model.dart' as card;
import 'package:famcards/features/cards/presentation/widgets/buttons/dismiss_button.dart';
import 'package:famcards/features/cards/presentation/widgets/buttons/remind_later_button.dart';
import 'package:famcards/features/cards/presentation/widgets/dynamic_formatted_text.dart';
import 'package:flutter/material.dart';

import '../../data/models/hc_group_model.dart';

class DesignHC3Widget extends StatefulWidget {
  final HcGroup hcGroup;

  const DesignHC3Widget({super.key, required this.hcGroup});

  @override
  State<DesignHC3Widget> createState() => _DesignHC3WidgetState();
}

class _DesignHC3WidgetState extends State<DesignHC3Widget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    if (widget.hcGroup.cards.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: widget.hcGroup.height - 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.hcGroup.cards.length,
        itemBuilder: (context, index) {
          final card = widget.hcGroup.cards[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildHc3Card(context, card),
          );
        },
      ),
    );
  }

  Widget _buildHc3Card(BuildContext context, card.Card card) {
    final double space = (MediaQuery.sizeOf(context).width - 80) / 2;
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: SizedBox(
        height: widget.hcGroup.height - 120,
        width: MediaQuery.sizeOf(context).width - 16,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              left: isSelected ? space : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: GestureDetector(
                onLongPress: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    card.bgImage?.imageUrl ?? "",
                    fit: BoxFit.cover,
                    width: MediaQuery.sizeOf(context).width - 16,
                  ),
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                left: 25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RemindLaterButton(id: card.id.toString()),
                    const SizedBox(height: 8),
                    DismissButton(id: card.id.toString()),
                  ],
                ),
              ),
            // Text Overlay with Padding
            Positioned(
              left: isSelected ? space + 50 : 50,
              right: 10,
              top: 200,
              child: DynamicFormattedText(
                formattedTitle: card.formattedTitle!,
              ),
            ),
            ...card.cta.map((cta) {
              return Positioned(
                left: isSelected ? space + 50 : 50,
                bottom: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await urlLauncher(card.url ?? "https://google.com");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: convertHexToColor(cta.bgColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    cta.text,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
