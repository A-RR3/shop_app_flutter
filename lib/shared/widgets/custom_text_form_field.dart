import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String hintText;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final InputBorder? border;
  final TextInputType textInputType;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
    required this.hintText,
    required this.prefixIcon,
    this.border,
    required this.textInputType,
    this.suffixIcon,
    this.obscureText = false,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

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
        border: border ?? const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
