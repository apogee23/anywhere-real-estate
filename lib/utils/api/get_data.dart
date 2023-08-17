import 'package:http/http.dart' as http;
import 'package:realogy/flavors.dart';

Future<http.Response> getData({
  required String url,
  // required String endpoint,
  Map<String, dynamic>? queryParameters,
}) async {
  try {
    // final userId = await Auth0Flutter2.instance.getLoggedInUserId();

    var headers = {
      // 'Authorization': "Bearer ${userId ?? ""}",
    };

    print(Uri.parse(
      url,
    ).toString());
    return http.get(
      Uri.parse(url),
      // headers: headers,
    );
  } catch (ex) {
    throw Exception(ex);
  }
}
