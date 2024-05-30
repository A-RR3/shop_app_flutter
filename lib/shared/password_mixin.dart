import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin PasswordVisibilityMixin<T> on Cubit<T> {
  bool isPasswordShown = false;
  Icon passwordIcon = const Icon(Icons.visibility_off);

  void showHidePassword(state) {
    isPasswordShown = !isPasswordShown;
    passwordIcon = isPasswordShown
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off);
    emit(state);
  }
}
