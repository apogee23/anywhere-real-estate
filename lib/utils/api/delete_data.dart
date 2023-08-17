import 'package:http/http.dart' as http;

Future<http.Response> deleteData({
  required String authority,
  required String endpoint,
}) async {
  try {
    // final userId = await Auth0Flutter2.instance.getLoggedInUserId();

    // var headers = {
    //   'Authorization': "Bearer ${userId ?? ""}",
    // };

    return http.delete(
      Uri.https(
        authority,
        endpoint,
      ),
      // headers: headers,
    );
  } catch (ex) {
    throw Exception(ex);
  }
}
