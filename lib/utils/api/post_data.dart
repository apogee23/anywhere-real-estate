import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> postData({
  required String authority,
  required String endpoint,
  Map<String, dynamic>? body,
}) async {
  try {
    //   final userId = await Auth0Flutter2.instance.getLoggedInUserId();

    var headers = {
      // 'Authorization': "Bearer ${userId ?? ""}",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    return http.post(
      Uri.https(
        authority,
        "$endpoint/",
      ),
      headers: headers,
      body: jsonEncode(body),
    );
  } catch (ex) {
    throw Exception(ex);
  }
}
