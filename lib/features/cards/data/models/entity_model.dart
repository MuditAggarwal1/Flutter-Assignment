class Entity {
  final String? text;
  final String? type;
  final String? color;
  final String? fontStyle;
  final String? fontFamily;
  final int? fontSize;

  Entity({
    required this.text,
    required this.type,
    required this.color,
    required this.fontStyle,
    required this.fontFamily,
    this.fontSize,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        text: json["text"] ?? "",
        type: json["type"] ?? "",
        color: json["color"] ?? "",
        fontStyle: json["font_style"] ?? "",
        fontFamily: json["font_family"] ?? "",
        fontSize: json["font_size"] ?? 14, // Default font size, e.g., 14
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "type": type,
        "color": color,
        "font_style": fontStyle,
        "font_family": fontFamily,
        "font_size": fontSize,
      };
}
