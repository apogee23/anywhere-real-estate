import 'dart:ui';
import 'package:flutter/material.dart';

Future<T?> showCommonModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isDismissable = false,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    // barrierColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: child,
      );
    },
  );
}
