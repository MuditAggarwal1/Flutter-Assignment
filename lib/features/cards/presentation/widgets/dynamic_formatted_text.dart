import 'package:famcards/core/utils/hex_to_color.dart';
import 'package:famcards/features/cards/data/models/entity_model.dart';
import 'package:famcards/features/cards/data/models/formatted_text_model.dart';
import 'package:flutter/material.dart';

class DynamicFormattedText extends StatelessWidget {
  final FormattedText formattedTitle;

  const DynamicFormattedText({super.key, required this.formattedTitle});

  @override
  Widget build(BuildContext context) {
    String text = formattedTitle.text;
    List<Entity> entities = formattedTitle.entities;

    // Generate TextSpans dynamically
    List<TextSpan> textSpans = [];
    int entityIndex = 0;

    // Split the text by "{}" and map to entities
    text.split("{}").forEach((segment) {
      // Add the plain text segment
      if (segment.isNotEmpty) {
        textSpans.add(TextSpan(
          text: segment,
          style: const TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ));
      }

      // Add the styled text from entities
      if (entityIndex < entities.length) {
        final entity = entities[entityIndex];
        textSpans.add(TextSpan(
          text: entity.text,
          style: TextStyle(
            color: convertHexToColor(entity.color),
            fontSize: (entity.fontSize as num?)?.toDouble(),
            decoration: entity.fontStyle == "underline"
                ? TextDecoration.underline
                : TextDecoration.none,
            fontWeight: (entity.fontFamily?.contains("bold") ?? false)
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ));
        entityIndex++;
      }
    });

    // Wrap with alignment
    return Align(
      alignment: _getAlignment(formattedTitle.align),
      child: RichText(
        text: TextSpan(children: textSpans),
        textAlign: _getTextAlign(formattedTitle.align),
      ),
    );
  }

  // Helper: Map align to Flutter alignment
  Alignment _getAlignment(String? align) {
    switch (align) {
      case "left":
        return Alignment.centerLeft;
      case "right":
        return Alignment.centerRight;
      case "center":
        return Alignment.center;
      default:
        return Alignment.centerLeft;
    }
  }

  // Helper: Map align to text alignment
  TextAlign _getTextAlign(String? align) {
    switch (align) {
      case "left":
        return TextAlign.left;
      case "right":
        return TextAlign.right;
      case "center":
        return TextAlign.center;
      default:
        return TextAlign.left;
    }
  }
}
