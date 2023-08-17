class MaintainerModel {
  final String github;

  MaintainerModel({
    required this.github,
  });

  factory MaintainerModel.fromJson(Map<String, dynamic> json) =>
      MaintainerModel(
        github: json["github"],
      );

  Map<String, dynamic> toJson() => {
        "github": github,
      };
}
