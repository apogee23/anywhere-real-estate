import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

Future<T?> showCommonModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isDismissable = false,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // barrierColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ThemeProvider.themeOf(context).data.backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20.0,
                sigmaY: 20.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(
                    color: Colors.black26,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
