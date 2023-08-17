import 'dart:convert';
import 'package:realogy/utils/crud/crud.dart';

import 'models.dart';

BaseModel baseModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

String baseModelToJson(BaseModel data) => json.encode(data.toJson());

class BaseModel {
  final String baseModelAbstract;
  final String abstractSource;
  final String abstractText;
  final String abstractUrl;
  final String answer;
  final String answerType;
  final String definition;
  final String definitionSource;
  final String definitionUrl;
  final String entity;
  final String heading;
  final String image;
  final int imageHeight;
  final int imageIsLogo;
  final int imageWidth;
  final String infobox;
  final String redirect;
  final List<RelatedTopicModel> relatedTopics;
  final List<dynamic> results;
  final String type;
  final MetaModel meta;

  BaseModel({
    required this.baseModelAbstract,
    required this.abstractSource,
    required this.abstractText,
    required this.abstractUrl,
    required this.answer,
    required this.answerType,
    required this.definition,
    required this.definitionSource,
    required this.definitionUrl,
    required this.entity,
    required this.heading,
    required this.image,
    required this.imageHeight,
    required this.imageIsLogo,
    required this.imageWidth,
    required this.infobox,
    required this.redirect,
    required this.relatedTopics,
    required this.results,
    required this.type,
    required this.meta,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        baseModelAbstract: json["Abstract"],
        abstractSource: json["AbstractSource"],
        abstractText: json["AbstractText"],
        abstractUrl: json["AbstractURL"],
        answer: json["Answer"],
        answerType: json["AnswerType"],
        definition: json["Definition"],
        definitionSource: json["DefinitionSource"],
        definitionUrl: json["DefinitionURL"],
        entity: json["Entity"],
        heading: json["Heading"],
        image: json["Image"],
        imageHeight: json["ImageHeight"],
        imageIsLogo: json["ImageIsLogo"],
        imageWidth: json["ImageWidth"],
        infobox: json["Infobox"],
        redirect: json["Redirect"],
        relatedTopics: List<RelatedTopicModel>.from(
          json["RelatedTopics"].map(
            (x) => RelatedTopicModel.fromJson(x),
          ),
        ),
        results: List<dynamic>.from(
          json["Results"].map((x) => x),
        ),
        type: json["Type"],
        meta: MetaModel.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "Abstract": baseModelAbstract,
        "AbstractSource": abstractSource,
        "AbstractText": abstractText,
        "AbstractURL": abstractUrl,
        "Answer": answer,
        "AnswerType": answerType,
        "Definition": definition,
        "DefinitionSource": definitionSource,
        "DefinitionURL": definitionUrl,
        "Entity": entity,
        "Heading": heading,
        "Image": image,
        "ImageHeight": imageHeight,
        "ImageIsLogo": imageIsLogo,
        "ImageWidth": imageWidth,
        "Infobox": infobox,
        "Redirect": redirect,
        "RelatedTopics": List<dynamic>.from(
          relatedTopics.map(
            (x) => x.toJson(),
          ),
        ),
        "Results": List<dynamic>.from(
          results.map((x) => x),
        ),
        "Type": type,
        "meta": meta.toJson(),
      };

  static Future<BaseModel?> read() async {
    return await readFuture(
      authority: "",
      endpoint: "https://api.duckduckgo.com/",
      fromJson: (json) => BaseModel.fromJson(json as Map<String, dynamic>),
      defaultValue: null,
    );
  }
}
