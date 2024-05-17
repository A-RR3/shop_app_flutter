import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/modules/login/cubit/login_states.dart';
import 'package:shop_app_flutter/shared/network/remote/dio_helper.dart';
import 'package:shop_app_flutter/shared/network/remote/end_points.dart';

import '../../../domain/models/user_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = false;
  Icon passwordIcon = const Icon(Icons.visibility_off);

  void showHidePassword() {
    isPasswordShown = !isPasswordShown;
    passwordIcon = isPasswordShown
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off);
    emit(ChangePasswordVisibilityState());
  }

  void loginUser({required String username, required String password}) async {
    emit(LoginLoadingState());
    try {
      var res = await DioHelper.postData(
          url: LOGIN, data: {'username': username, 'password': password});
      if (res.statusCode == 200) {
        emit(LoginSuccessState(
            'تم تسجيل الدخول بنجاح', UserModel.fromJson(res.data)));
      }
      if (res.statusCode == 400) {
        emit(LoginErrorState('يرجى التأكد من البيانات المدخلة'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 400:
            emit(LoginErrorState('يرجى التأكد من البيانات المدخلة'));
            break;
          default:
            emit(LoginErrorState(
                'حدث خطأ غير متوقع. رمز الخطأ: ${e.response?.statusCode}'));
        }
      }
    } catch (e) {
      emit(LoginErrorState('حدث خطأ أثناء الاتصال بالخادم'));
    }
  }
}
