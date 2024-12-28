import 'package:famcards/features/cards/data/models/image_asset_model.dart';

class PositionalImage {
  final ImageAsset image;
  final String position;

  PositionalImage({
    required this.image,
    required this.position,
  });

  factory PositionalImage.fromJson(Map<String, dynamic> json) =>
      PositionalImage(
        image: ImageAsset.fromJson(json["image"] ?? {}),
        position: json["position"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "image": image.toJson(),
        "position": position,
      };
}
