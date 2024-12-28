class Component {
  final String type;
  final Map<String, dynamic> properties;

  Component({
    required this.type,
    required this.properties,
  });

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        type: json["type"],
        properties: json["properties"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties,
      };
}
