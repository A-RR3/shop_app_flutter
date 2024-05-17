import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String hintText;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final InputBorder border;
  final TextInputType textInputType;
  final bool obscureText;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      required this.onChanged,
      required this.hintText,
      required this.prefixIcon,
      required this.border,
      required this.textInputType,
      this.suffixIcon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: true,
      controller: controller,
      keyboardType: textInputType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: border,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
    );
  }
}
