import 'package:realogy/utils/crud/crud.dart';

class CRUDBaseModel {
  static String authority = "";
  static String endpoint = "";
  String? id;

  static CRUDBaseModel? fromJson(Map<dynamic, dynamic>? json) {
    return null;
  }

  Map<String, dynamic> toJson({bool isUpdate = false}) {
    return <String, dynamic>{};
  }

  Future<CRUDBaseModel?> save({Map<String, dynamic>? body}) async {
    try {
      if (id != null) {
        return updateFuture(
          authority: authority,
          endpoint: endpoint,
          id: id ?? "",
          body: body,
          fromJson: fromJson,
          defaultValue: CRUDBaseModel(),
        );
      } else {
        return createFuture(
            authority: authority,
            endpoint: endpoint,
            body: body,
            fromJson: fromJson,
            defaultValue: CRUDBaseModel());
      }
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<void> delete() async {
    return deleteFuture(
      authority: authority,
      endpoint: endpoint,
      id: id ?? "",
      fromJson: fromJson,
    );
  }

  static Future<List<CRUDBaseModel>> readAll() async {
    return readListFuture(
        authority: authority,
        endpoint: endpoint,
        fromJson: (json) => CRUDBaseModel.fromJson(json),
        defaultValue: CRUDBaseModel());
  }

  static Future<CRUDBaseModel> read(String id) async {
    return readFuture(
        authority: authority,
        endpoint: endpoint,
        fromJson: (json) => CRUDBaseModel.fromJson(json),
        defaultValue: CRUDBaseModel());
  }
}
