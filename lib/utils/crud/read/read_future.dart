import 'dart:convert';
import 'package:realogy/utils/api/get_data.dart';

Future<T> readFuture<T>({
  required String url,
  required T? Function(Map<dynamic, dynamic>? json) fromJson,
  required T defaultValue,
}) async {
  try {
    var response = await getData(
      url: url,
    );
    print(response.body);
    return fromJson(jsonDecode(utf8.decode(response.bodyBytes))) ??
        defaultValue;
  } catch (ex) {
    throw Exception(ex);
  }
}
