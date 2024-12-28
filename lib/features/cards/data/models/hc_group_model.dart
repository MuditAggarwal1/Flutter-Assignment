import 'package:famcards/features/cards/data/models/card_model.dart';
import 'package:famcards/features/cards/data/models/contextual_card_model.dart';

class HcGroup {
  final int id;
  final String name;
  final DesignType designType;
  final int cardType;
  final List<Card> cards;
  final bool isScrollable;
  final double height;
  final bool isFullWidth;
  final String? slug;
  final int level;

  HcGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.cardType,
    required this.cards,
    required this.isScrollable,
    required this.height,
    required this.isFullWidth,
    this.slug,
    required this.level,
  });

  HcGroup copyWith({
    int? id,
    String? name,
    DesignType? designType,
    int? cardType,
    List<Card>? cards,
    bool? isScrollable,
    double? height,
    bool? isFullWidth,
    String? slug,
    int? level,
  }) =>
      HcGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        designType: designType ?? this.designType,
        cardType: cardType ?? this.cardType,
        cards: cards ?? this.cards,
        isScrollable: isScrollable ?? this.isScrollable,
        height: height ?? this.height,
        isFullWidth: isFullWidth ?? this.isFullWidth,
        slug: slug ?? this.slug,
        level: level ?? this.level,
      );

  factory HcGroup.fromJson(Map<String, dynamic> json) => HcGroup(
        id: json['id'] as int? ?? 0,
        name: json['name'] as String? ?? '',
        cardType: json['card_type'] as int? ?? 0,
        cards: (json['cards'] as List<dynamic>?)
                ?.map((card) => Card.fromJson(card as Map<String, dynamic>))
                .toList() ??
            [],
        designType: DesignType.fromString(json["design_type"]),
        isScrollable: json["is_scrollable"] as bool? ?? false,
        height: (json["height"] as num?)?.toDouble() ?? 0.0,
        isFullWidth: json["is_full_width"] as bool? ?? false,
        slug: json["slug"] as String?,
        level: json["level"] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "design_type": designType.toString().split('.').last,
        "card_type": cardType,
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "is_scrollable": isScrollable,
        "height": height,
        "is_full_width": isFullWidth,
        "slug": slug,
        "level": level,
      };
}
