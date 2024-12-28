class Cta {
  final String text;
  final String type;
  final String bgColor;
  final bool isCircular;
  final bool isSecondary;
  final int strokeWidth;

  Cta({
    required this.text,
    required this.type,
    required this.bgColor,
    required this.isCircular,
    required this.isSecondary,
    required this.strokeWidth,
  });

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(
        text: json['text'] ?? '',
        type: json['type'] ?? '',
        bgColor: json['bg_color'] ?? '',
        isCircular: json['is_circular'] ?? false,
        isSecondary: json['is_secondary'] ?? false,
        strokeWidth: (json['stroke_width'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "type": type,
        "bg_color": bgColor,
        "is_circular": isCircular,
        "is_secondary": isSecondary,
        "stroke_width": strokeWidth,
      };
}
