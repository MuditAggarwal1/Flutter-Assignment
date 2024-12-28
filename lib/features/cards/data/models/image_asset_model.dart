class ImageAsset {
  final String imageType;
  final String imageUrl;
  final double aspectRatio;

  ImageAsset({
    required this.imageType,
    required this.imageUrl,
    required this.aspectRatio,
  });

  factory ImageAsset.fromJson(Map<String, dynamic> json) => ImageAsset(
        imageType: json["image_type"] ?? '',
        imageUrl: json["image_url"] ?? '',
        aspectRatio: json["aspect_ratio"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "image_type": imageType,
        "image_url": imageUrl,
        "aspect_ratio": aspectRatio,
      };
}
