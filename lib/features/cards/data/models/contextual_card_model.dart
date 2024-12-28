// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:famcards/features/cards/data/models/formatted_text_model.dart';
import 'package:famcards/features/cards/data/models/hc_group_model.dart';

// Example JSON structure and corresponding classes:
/*
{
  "id": 1,
  "slug": "famx-paypage",
  "hc_groups": [                                  // List<HcGroup>
    {
      "id": 76,
      "name": "cardwithaction",
      "design_type": "HC3",                      // DesignType enum
      "card_type": 1,
      "cards": [                                 // List<Card>
        {
          "id": 2,
          "name": "Test hcc",
          "slug": "Testhccwithaction",
          "title": "Big display card\nwith action\nThis is a sample text",
          "formatted_title": {                   // FormattedText
            "text": "{}\nwith action\n{}",
            "align": "left",
            "entities": [                        // List<Entity>
              {
                "text": "Big display card",
                "type": "generic_text",
                "color": "#FBAF03",
                "font_size": 30,
                "font_style": "underline",
                "font_family": "met_semi_bold"
              }
            ]
          },
          "bg_image": {                          // ImageAsset
            "image_type": "ext",
            "image_url": "https://example.com/image.webp",
            "aspect_ratio": 0.9142857
          },
          "cta": [                               // List<Cta>
            {
              "text": "Action",
              "type": "normal",
              "bg_color": "#000000",
              "is_circular": false,
              "is_secondary": false,
              "stroke_width": 0
            }
          ],
          "bg_gradient": {                       // BgGradient
            "angle": 336,
            "colors": ["#FBAF03", "#FFD428"]
          }
        }
      ],
      "is_scrollable": false,
      "height": 600,
      "is_full_width": false,
      "level": 0
    }
  ]
}
*/

enum DesignType {
  HC1,
  HC3,
  HC5,
  HC6,
  HC9;

  factory DesignType.fromString(String type) {
    return DesignType.values.firstWhere(
      (e) => e.toString() == 'DesignType.$type',
      orElse: () => HC1,
    );
  }
}

List<ContextualCards> contextualCardsFromJson(String str) =>
    List<ContextualCards>.from(
        json.decode(str).map((x) => ContextualCards.fromJson(x)));

String contextualCardsToJson(List<ContextualCards> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContextualCards {
  final int id;
  final String slug;
  final String? title;
  final FormattedText? formattedTitle;
  final String? description;
  final FormattedText? formattedDescription;
  final Map<String, dynamic>? assets;
  final List<HcGroup> hcGroups;

  ContextualCards({
    required this.id,
    required this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.assets,
    required this.hcGroups,
  });

  ContextualCards copyWith({
    int? id,
    String? slug,
    String? title,
    FormattedText? formattedTitle,
    String? description,
    FormattedText? formattedDescription,
    Map<String, dynamic>? assets,
    List<HcGroup>? hcGroups,
  }) =>
      ContextualCards(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        title: title ?? this.title,
        formattedTitle: formattedTitle ?? this.formattedTitle,
        description: description ?? this.description,
        formattedDescription: formattedDescription ?? this.formattedDescription,
        assets: assets ?? this.assets,
        hcGroups: hcGroups ?? this.hcGroups,
      );

  factory ContextualCards.fromJson(Map<String, dynamic> json) =>
      ContextualCards(
        id: json['id'],
        slug: json['slug'],
        title: json['title'],
        formattedTitle: json["formatted_title"] != null
            ? FormattedText.fromJson(json["formatted_title"])
            : null,
        description: json['description'] ?? '',
        formattedDescription: json["formatted_description"] != null
            ? FormattedText.fromJson(json["formatted_description"])
            : null,
        assets: json['assets'] ?? {},
        hcGroups: (json['hc_groups'] as List?)
                ?.map((group) => HcGroup.fromJson(group))
                .toList() ??
            [],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "formatted_title": formattedTitle?.toJson(),
        "description": description,
        "formatted_description": formattedDescription?.toJson(),
        "assets": assets,
        "hc_groups": List<dynamic>.from(hcGroups.map((x) => x.toJson())),
      };
}
