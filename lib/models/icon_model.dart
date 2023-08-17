class IconModel {
  final String height;
  final String url;
  final String width;

  IconModel({
    required this.height,
    required this.url,
    required this.width,
  });

  factory IconModel.fromJson(Map<String, dynamic> json) => IconModel(
        height: json["Height"],
        url: json["URL"],
        width: json["Width"],
      );

  Map<String, dynamic> toJson() => {
        "Height": height,
        "URL": url,
        "Width": width,
      };
}
