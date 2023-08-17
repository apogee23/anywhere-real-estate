import 'dart:convert';
import 'package:http/http.dart' as http;

Future<T> autoscalingFunctionPost<T>({
  required String namespace,
  required String authorization,
  required String methodName,
  required Map<String, dynamic>? body,
  required T? Function(Map<dynamic, dynamic>? json) fromJson,
  required T defaultValue,
}) async {
  try {
    var headers = {
      "Authorization": "Basic $authorization",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    var response = await http.post(
      Uri.parse(
        "https://faas-nyc1-2ef2e6cc.doserverless.co/api/v1/namespaces/$namespace/actions/$methodName?blocking=true&result=true",
      ),
      headers: headers,
      body: jsonEncode(body),
    );

    return fromJson(
          jsonDecode(utf8.decode(response.bodyBytes))['body'],
        ) ??
        defaultValue;
  } catch (ex) {
    return defaultValue;
  }
}
