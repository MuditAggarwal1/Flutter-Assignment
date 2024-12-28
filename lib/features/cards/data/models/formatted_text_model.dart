import 'package:famcards/features/cards/data/models/entity_model.dart';

class FormattedText {
  final String text;
  final String align;
  final List<Entity> entities;

  FormattedText({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory FormattedText.fromJson(Map<String, dynamic> json) => FormattedText(
        text: json['text'] ?? '',
        align: json['align'] ?? '',
        entities: (json['entities'] as List?)
                ?.map((entity) => Entity.fromJson(entity))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "align": align,
        "entities": List<dynamic>.from(entities.map((x) => x.toJson())),
      };
}
