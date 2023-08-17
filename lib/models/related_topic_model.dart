import 'models.dart';

class RelatedTopicModel {
  final String firstUrl;
  final IconModel icon;
  final String result;
  final String text;

  RelatedTopicModel({
    required this.firstUrl,
    required this.icon,
    required this.result,
    required this.text,
  });

  factory RelatedTopicModel.fromJson(Map<String, dynamic> json) =>
      RelatedTopicModel(
        firstUrl: json["FirstURL"],
        icon: IconModel.fromJson(json["Icon"]),
        result: json["Result"],
        text: json["Text"],
      );

  Map<String, dynamic> toJson() => {
        "FirstURL": firstUrl,
        "Icon": icon.toJson(),
        "Result": result,
        "Text": text,
      };
}
