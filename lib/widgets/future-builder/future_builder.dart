import 'dart:convert';
import 'package:realogy/colors/custom_colors.dart';
import 'package:realogy/screens/error_screen.dart';
import 'package:realogy/widgets/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PBFutureBuilder<T> extends StatefulWidget {
  const PBFutureBuilder({
    Key? key,
    required this.future,
    required this.body,
    this.loader,
    this.errorMessage,
  }) : super(key: key);

  final Future<T> future;
  final Widget Function(T?) body;
  final Widget? loader;
  final String? errorMessage;

  @override
  _PBFutureBuilderState<T> createState() => _PBFutureBuilderState<T>();
}

class _PBFutureBuilderState<T> extends State<PBFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          logError(
            "${snapshot.error} - ${snapshot.stackTrace}",
          );
          return ErrorScreen(
            errorMessage: widget.errorMessage,
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return widget.body(snapshot.data);
        } else {
          return widget.loader ??
              const Loader(
                color: CustomColors.primary,
              );
        }
      },
    );
  }

  void logError(String message) async {
    var headers = {
      "Authorization": "Bearer 7gwqThf2Tb2JTGe3KYgbetyu",
      "Content-Type": "application/json",
    };

    String? userId;
    try {
      // userId = await Auth0Flutter2.instance.getLoggedInUserId();
    } catch (ex) {
      print(ex);
    }

    var body = {
      "message": "${userId ?? "[No User Id]"} - $message}",
    };

    await http.post(
      Uri.parse(
        "https://in.logtail.com/",
      ),
      headers: headers,
      body: jsonEncode(body),
    );
  }
}
