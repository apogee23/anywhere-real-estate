class DeveloperModel {
  final String name;
  final String type;
  final String url;

  DeveloperModel({
    required this.name,
    required this.type,
    required this.url,
  });

  factory DeveloperModel.fromJson(Map<String, dynamic> json) => DeveloperModel(
        name: json["name"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "url": url,
      };
}
