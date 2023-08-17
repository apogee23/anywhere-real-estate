import 'dart:convert';
import 'package:realogy/utils/api/patch_data.dart';

Future<T> updateFuture<T>({
  required String authority,
  required String endpoint,
  required String id,
  required Map<String, dynamic>? body,
  required T? Function(Map<dynamic, dynamic>? json) fromJson,
  required T defaultValue,
}) async {
  try {
    var response = await patchData(
      authority: authority,
      endpoint: "$endpoint${id != "" ? "/$id" : ""}",
      body: body,
    );
    return fromJson(jsonDecode(utf8.decode(response.bodyBytes))) ??
        defaultValue;
  } catch (ex) {
    throw Exception(ex);
  }
}
