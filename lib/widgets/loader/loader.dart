import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, required this.color, this.centered = true})
      : super(key: key);

  final Color color;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    if (centered) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color,
          ),
        ),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color,
        ),
      );
    }
  }
}
