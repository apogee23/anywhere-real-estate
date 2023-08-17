import 'dart:convert';
import 'package:realogy/utils/api/get_data.dart';

Future<T> readFuture<T>({
  required String authority,
  required String endpoint,
  required T? Function(Map<dynamic, dynamic>? json) fromJson,
  required T defaultValue,
  Map<String, dynamic>? queryParameters,
}) async {
  try {
    var response = await getData(
      authority: authority,
      endpoint: endpoint,
      queryParameters: queryParameters,
    );
    return fromJson(jsonDecode(utf8.decode(response.bodyBytes))) ??
        defaultValue;
  } catch (ex) {
    throw Exception(ex);
  }
}
