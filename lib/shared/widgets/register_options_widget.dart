import 'package:flutter/material.dart';

class RegisterOptions extends StatelessWidget {
  final String question;
  final String action;
  final VoidCallback onPressed;

  const RegisterOptions(
      {super.key,
      required this.question,
      required this.action,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question),
        TextButton(
          onPressed: onPressed,
          child: Text(action),
        ),
      ],
    );
  }
}
