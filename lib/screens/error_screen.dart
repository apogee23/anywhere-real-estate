import 'package:realogy/colors/custom_colors.dart';
import 'package:realogy/main.dart';
import 'package:realogy/providers/providers.dart';
import 'package:realogy/widgets/submit-button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_provider/theme_provider.dart';

class ErrorScreen extends ConsumerStatefulWidget {
  const ErrorScreen({
    super.key,
    this.errorMessage,
  });

  final String? errorMessage;

  @override
  ConsumerState<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends ConsumerState<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    var dataState = ref.watch(dataProvider);

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).data.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 170,
                    padding: const EdgeInsets.all(35),
                    decoration: const BoxDecoration(
                      color: CustomColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.warning,
                      size: 100,
                      color: ThemeProvider.themeOf(
                        context,
                      ).data.backgroundColor,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.1),
                  const Text(
                    "Try Again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.06),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Text(
                      widget.errorMessage ??
                          "Oops! Something went wrong. Please try again.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.06),
                  SizedBox(
                    width: screenSize.width * 0.5,
                    child: SubmitButton(
                        text: "Try Again", onPressed: () async => {}),
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                  TextButton(
                    onPressed: () {},
                    // onPressed: () async => await userState.logout(),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        color: CustomColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
