import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}
