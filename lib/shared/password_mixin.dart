import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//password state
// class ChangePasswordVisibilityState {}

//generic cubit class for both login and register cubits
// class GenericCubit<T> extends Cubit<T> {
//   GenericCubit(T initialState) : super(initialState);
// }

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
