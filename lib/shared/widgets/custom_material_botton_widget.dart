import 'package:flutter/material.dart';
import 'package:shop_app_flutter/core/presentation/Palette.dart';

class CustomMaterialBotton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const CustomMaterialBotton(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(width: 1, color: Palette.materialBottonBorder)),
      onPressed: onPressed,
      color: Palette.primaryColor,
      minWidth: double.infinity,
      height: 50,
      child: child,
    );
  }
}
