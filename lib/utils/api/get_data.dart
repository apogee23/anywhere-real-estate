import 'package:http/http.dart' as http;

Future<http.Response> getData({
  required String authority,
  required String endpoint,
  Map<String, dynamic>? queryParameters,
}) async {
  try {
    // final userId = await Auth0Flutter2.instance.getLoggedInUserId();

    var headers = {
      // 'Authorization': "Bearer ${userId ?? ""}",
    };

    print(Uri.https(
      authority,
      "$endpoint/",
      queryParameters,
    ).toString());
    return http.get(
      Uri.https(
        authority,
        "$endpoint/",
        queryParameters,
      ),
      // headers: headers,
    );
  } catch (ex) {
    throw Exception(ex);
  }
}
