import 'package:realogy/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataProvider = ChangeNotifierProvider<DataStateNotifier>((ref) {
  return DataStateNotifier();
});

class DataStateNotifier extends ChangeNotifier {
  static BaseModel? _data;

  BaseModel? get data => _data;

  Future<BaseModel?> getData() async {
    _data = await BaseModel.read();

    notifyListeners();
    return _data;
  }
}
