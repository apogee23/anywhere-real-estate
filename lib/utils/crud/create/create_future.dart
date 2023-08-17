import 'dart:convert';
import 'package:realogy/utils/api/post_data.dart';

Future<T> createFuture<T>({
  required String authority,
  required String endpoint,
  required Map<String, dynamic>? body,
  required T? Function(Map<dynamic, dynamic>? json) fromJson,
  required T defaultValue,
}) async {
  try {
    var response = await postData(
      authority: authority,
      endpoint: endpoint,
      body: body,
    );
    return fromJson(jsonDecode(utf8.decode(response.bodyBytes))) ??
        defaultValue;
  } catch (ex) {
    throw Exception(ex);
  }
}
