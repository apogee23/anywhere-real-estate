import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:realogy/colors/custom_colors.dart';
import 'package:realogy/widgets/submit-button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class CelebrationScreen extends StatefulWidget {
  const CelebrationScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.action,
    this.secondaryActions,
    this.icon,
  });

  final String title;
  final String subtitle;
  final String actionText;
  final void Function(BuildContext context) action;
  final Widget Function(BuildContext context)? secondaryActions;
  final IconData? icon;

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    super.initState();
    setState(() {
      initController();
    });
  }

  void initController() {
    _controllerTopCenter = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _controllerTopCenter.play();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).data.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildConfettiWidget(_controllerTopCenter, 1 * pi / 4),
            buildConfettiWidget(_controllerTopCenter, 2 * pi / 4),
            buildConfettiWidget(_controllerTopCenter, 3 * pi / 4),
            buildConfettiWidget(_controllerTopCenter, 4 * pi / 4),
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
                      widget.icon ?? Icons.military_tech,
                      size: 100,
                      color:
                          ThemeProvider.themeOf(context).data.backgroundColor,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.06),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Text(
                      widget.subtitle,
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
                      text: widget.actionText,
                      onPressed: () async => widget.action(context),
                    ),
                  ),
                  if (widget.secondaryActions != null)
                    widget.secondaryActions!(context),
                ],
              ),
            ),
            // buildButton()
          ],
        ),
      ),
    );
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        minimumSize: const Size(1, 1),
        maximumSize: const Size(10, 10),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.directional,
        maxBlastForce: 30,
        minBlastForce: 5,
        emissionFrequency: 0.2,
        numberOfParticles: 8,
        gravity: 1,
        colors: const [
          CustomColors.secondary,
          CustomColors.primary,
        ],
      ),
    );
  }
}
