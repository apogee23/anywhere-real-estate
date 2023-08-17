List<T> getModelList<T>(
  List<dynamic> jsonList, {
  required T? Function(Map<dynamic, dynamic>?) converter,
}) {
  try {
    List<T> list = [];
    for (var item in jsonList) {
      try {
        var convertedItem = converter(item as Map<dynamic, dynamic>?);
        if (convertedItem != null) {
          list.add(convertedItem);
        }
      } catch (e) {
        print(e);
        // Do nothing.
      }
    }
    return list;
  } catch (e) {
    throw Exception(e);
  }
}
