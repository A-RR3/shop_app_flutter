import '../../../domain/models/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String message;
  UserModel userModel;
  LoginSuccessState(this.message, this.userModel);
}

class LoginErrorState extends LoginStates {
  final String message;
  LoginErrorState(this.message);
}

class ChangePasswordVisibilityState extends LoginStates {}
