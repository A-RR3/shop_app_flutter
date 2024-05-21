import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/modules/register/cubit/register_states.dart';
import 'package:shop_app_flutter/shared/password_mixin.dart';

import '../../../domain/models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>
    with PasswordVisibilityMixin<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late ProfileModel profileModel;
  FocusNode name = FocusNode();
  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  FocusNode phone = FocusNode();

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(RegisterSuccessState(profileModel));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
}
