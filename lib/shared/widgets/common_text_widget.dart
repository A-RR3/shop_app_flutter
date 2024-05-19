import 'package:flutter/material.dart';

class CommonTextWidget extends StatelessWidget {
  final String text;
  const CommonTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
