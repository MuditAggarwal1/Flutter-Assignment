import 'package:famcards/features/cards/data/models/bg_gradient_model.dart';
import 'package:famcards/features/cards/data/models/component_model.dart';
import 'package:famcards/features/cards/data/models/cta_model.dart';
import 'package:famcards/features/cards/data/models/formatted_text_model.dart';
import 'package:famcards/features/cards/data/models/image_asset_model.dart';
import 'package:famcards/features/cards/data/models/positional_image_model.dart';

class Card {
  final int id;
  final String name;
  final String slug;
  final String? title;
  final FormattedText? formattedTitle;
  final List<PositionalImage> positionalImages;
  final List<Component> components;
  final String? url;
  final ImageAsset? bgImage;
  final List<Cta> cta;
  final bool isDisabled;
  final bool isShareable;
  final bool isInternal;
  final ImageAsset? icon;
  final String? bgColor;
  final int? iconSize;
  final BgGradient? bgGradient;
  final String? description;
  final FormattedText? formattedDescription;

  Card({
    required this.id,
    required this.name,
    required this.slug,
    this.title,
    this.formattedTitle,
    required this.positionalImages,
    required this.components,
    this.url,
    this.bgImage,
    required this.cta,
    required this.isDisabled,
    required this.isShareable,
    required this.isInternal,
    this.icon,
    this.bgColor,
    this.iconSize,
    this.bgGradient,
    this.description,
    this.formattedDescription,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        slug: json["slug"] ?? "",
        title: json["title"] ?? "",
        formattedTitle: json["formatted_title"] != null
            ? FormattedText.fromJson(json["formatted_title"])
            : null,
        positionalImages: json["positional_images"] != null
            ? List<PositionalImage>.from(json["positional_images"]
                .map((x) => PositionalImage.fromJson(x)))
            : [],
        components: json["components"] != null
            ? List<Component>.from(
                json["components"].map((x) => Component.fromJson(x)))
            : [],
        url: json["url"],
        bgImage: json["bg_image"] != null
            ? ImageAsset.fromJson(json["bg_image"])
            : null,
        cta: json["cta"] != null
            ? List<Cta>.from(json["cta"].map((x) => Cta.fromJson(x)))
            : [],
        isDisabled: json["is_disabled"] ?? false,
        isShareable: json["is_shareable"] ?? false,
        isInternal: json["is_internal"] ?? false,
        icon: json["icon"] != null ? ImageAsset.fromJson(json["icon"]) : null,
        bgColor: json["bg_color"] ?? "",
        iconSize: json["icon_size"] ?? 0,
        bgGradient: json["bg_gradient"] != null
            ? BgGradient.fromJson(json["bg_gradient"])
            : null,
        description: json["description"] ?? "",
        formattedDescription: json["formatted_description"] != null
            ? FormattedText.fromJson(json["formatted_description"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "title": title,
        "formatted_title": formattedTitle?.toJson(),
        "positional_images":
            List<dynamic>.from(positionalImages.map((x) => x.toJson())),
        "components": List<dynamic>.from(components.map((x) => x.toJson())),
        "url": url,
        "bg_image": bgImage?.toJson(),
        "cta": List<dynamic>.from(cta.map((x) => x.toJson())),
        "is_disabled": isDisabled,
        "is_shareable": isShareable,
        "is_internal": isInternal,
        "icon": icon?.toJson(),
        "bg_color": bgColor,
        "icon_size": iconSize,
        "bg_gradient": bgGradient?.toJson(),
        "description": description,
        "formatted_description": formattedDescription?.toJson(),
      };
}
