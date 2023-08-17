import 'package:realogy/colors/custom_colors.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  final String text;
  final Future<void> Function() onPressed;
  final bool disabled;

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            CustomColors.primary,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: _isLoading || widget.disabled
            ? null
            : () async {
                try {
                  setState(() {
                    _isLoading = true;
                  });

                  await widget.onPressed();
                } catch (ex) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: " + ex.toString()),
                      duration: const Duration(seconds: 4),
                    ),
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: _isLoading
              ? const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    CustomColors.screenBackground,
                  ),
                )
              : Text(
                  widget.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
