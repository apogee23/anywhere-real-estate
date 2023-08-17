import 'dart:convert';
import 'package:realogy/utils/api/get_data.dart';
import 'package:realogy/utils/get_model_list.dart';

Future<List<T>> readListFuture<T>({
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
    return getModelList(
      jsonDecode(utf8.decode(response.bodyBytes)),
      converter: (json) => fromJson(json),
    );
  } catch (ex) {
    throw Exception(ex);
  }
}
