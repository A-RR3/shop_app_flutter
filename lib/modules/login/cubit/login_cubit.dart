import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/modules/login/cubit/login_states.dart';
import 'package:shop_app_flutter/shared/network/remote/dio_helper.dart';
import 'package:shop_app_flutter/shared/network/remote/end_points.dart';

import '../../../domain/models/login_model.dart';
import '../../../shared/password_mixin.dart';

class LoginCubit extends Cubit<LoginStates>
    with PasswordVisibilityMixin<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      LoginModel loginModel = LoginModel.fromJson(value.data);
      // value.
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }
}
