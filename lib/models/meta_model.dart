import 'models.dart';

class MetaModel {
  final dynamic attribution;
  final dynamic blockgroup;
  final dynamic createdDate;
  final String description;
  final dynamic designer;
  final dynamic devDate;
  final String devMilestone;
  final List<DeveloperModel> developer;
  final String exampleQuery;
  final String id;
  final dynamic isStackexchange;
  final String jsCallbackName;
  final dynamic liveDate;
  final MaintainerModel maintainer;
  final String name;
  final String perlModule;
  final dynamic producer;
  final String productionState;
  final String repo;
  final String signalFrom;
  final String srcDomain;
  final int srcId;
  final String srcName;
  final SrcOptions srcOptions;
  final dynamic srcUrl;
  final String status;
  final String tab;
  final List<String> topic;
  final int unsafe;

  MetaModel({
    required this.attribution,
    required this.blockgroup,
    required this.createdDate,
    required this.description,
    required this.designer,
    required this.devDate,
    required this.devMilestone,
    required this.developer,
    required this.exampleQuery,
    required this.id,
    required this.isStackexchange,
    required this.jsCallbackName,
    required this.liveDate,
    required this.maintainer,
    required this.name,
    required this.perlModule,
    required this.producer,
    required this.productionState,
    required this.repo,
    required this.signalFrom,
    required this.srcDomain,
    required this.srcId,
    required this.srcName,
    required this.srcOptions,
    required this.srcUrl,
    required this.status,
    required this.tab,
    required this.topic,
    required this.unsafe,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        attribution: json["attribution"],
        blockgroup: json["blockgroup"],
        createdDate: json["created_date"],
        description: json["description"],
        designer: json["designer"],
        devDate: json["dev_date"],
        devMilestone: json["dev_milestone"],
        developer: List<DeveloperModel>.from(
            json["developer"].map((x) => DeveloperModel.fromJson(x))),
        exampleQuery: json["example_query"],
        id: json["id"],
        isStackexchange: json["is_stackexchange"],
        jsCallbackName: json["js_callback_name"],
        liveDate: json["live_date"],
        maintainer: MaintainerModel.fromJson(json["maintainer"]),
        name: json["name"],
        perlModule: json["perl_module"],
        producer: json["producer"],
        productionState: json["production_state"],
        repo: json["repo"],
        signalFrom: json["signal_from"],
        srcDomain: json["src_domain"],
        srcId: json["src_id"],
        srcName: json["src_name"],
        srcOptions: SrcOptions.fromJson(json["src_options"]),
        srcUrl: json["src_url"],
        status: json["status"],
        tab: json["tab"],
        topic: List<String>.from(json["topic"].map((x) => x)),
        unsafe: json["unsafe"],
      );

  Map<String, dynamic> toJson() => {
        "attribution": attribution,
        "blockgroup": blockgroup,
        "created_date": createdDate,
        "description": description,
        "designer": designer,
        "dev_date": devDate,
        "dev_milestone": devMilestone,
        "developer": List<dynamic>.from(developer.map((x) => x.toJson())),
        "example_query": exampleQuery,
        "id": id,
        "is_stackexchange": isStackexchange,
        "js_callback_name": jsCallbackName,
        "live_date": liveDate,
        "maintainer": maintainer.toJson(),
        "name": name,
        "perl_module": perlModule,
        "producer": producer,
        "production_state": productionState,
        "repo": repo,
        "signal_from": signalFrom,
        "src_domain": srcDomain,
        "src_id": srcId,
        "src_name": srcName,
        "src_options": srcOptions.toJson(),
        "src_url": srcUrl,
        "status": status,
        "tab": tab,
        "topic": List<dynamic>.from(topic.map((x) => x)),
        "unsafe": unsafe,
      };
}
