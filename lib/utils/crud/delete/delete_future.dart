import 'package:realogy/utils/api/delete_data.dart';

Future<void> deleteFuture<T>({
  required String authority,
  required String endpoint,
  required String id,
  required T? Function(Map<dynamic, dynamic>? json) fromJson,
}) async {
  try {
    await deleteData(
      authority: authority,
      endpoint: "$endpoint/$id/",
    );
    return;
  } catch (ex) {
    throw Exception(ex);
  }
}
