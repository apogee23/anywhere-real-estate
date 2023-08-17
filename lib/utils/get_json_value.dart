extension GetJsonValue on Map<dynamic, dynamic> {
  dynamic getJsonValue(String key, {var defaultValue}) {
    return containsKey(key) ? this[key] : defaultValue;
  }
}
