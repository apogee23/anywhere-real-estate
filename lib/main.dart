import 'dart:async';
import 'package:realogy/screens/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FutureOr<void> main() async {
  runApp(
    const MaterialApp(
      home: ProviderScope(
        child: ListScreen(),
      ),
    ),
  );
}
