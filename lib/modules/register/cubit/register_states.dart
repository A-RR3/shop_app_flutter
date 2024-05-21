import 'package:shop_app_flutter/domain/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final ProfileModel profileModel;
  RegisterSuccessState(this.profileModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class ChangePasswordVisibilityState extends RegisterStates {}
