import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_flutter/core/utils/navigation_services.dart';
import 'package:shop_app_flutter/modules/home_page/home_screen.dart';
import 'package:shop_app_flutter/modules/register/register_screen.dart';
import 'package:shop_app_flutter/shared/constants.dart';
import 'package:shop_app_flutter/shared/widgets/custom_material_botton_widget.dart';
import 'package:shop_app_flutter/shared/widgets/custom_text_form_field.dart';
import 'package:shop_app_flutter/shared/widgets/register_options_widget.dart';

import '../../shared/network/local/cache_helper.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  var loginFormKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({super.key});

  void showToast({required String meg, required ToastStates toastState}) async {
    await Fluttertoast.showToast(
        msg: meg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor:
            toastState == ToastStates.error ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if (state is LoginSuccessState) {
            showToast(meg: state.message, toastState: ToastStates.success);
            CacheHelper.setData(key: 'token', value: state.userModel.token)
                .then((value) {
              String? token = state.userModel.token;
              NavigationServices.navigateTo(context, const HomePage(),
                  removeAll: true);
            });
          }
          if (state is LoginErrorState) {
            showToast(meg: state.message, toastState: ToastStates.error);
          }
        },
        builder: (BuildContext context, LoginStates state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        vSpace(),
                        Text(
                          'Discover a world of products at your fingertips. Login and start shopping.',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey[800]),
                        ),
                        vSpace(40),
                        CustomTextFormField(
                          controller: userNameController,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          hintText: 'User Name',
                          prefixIcon: Icons.person,
                          border: const OutlineInputBorder(),
                          onChanged: (String data) {},
                        ),
                        vSpace(),
                        CustomTextFormField(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: !loginCubit.isPasswordShown,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginCubit.showHidePassword();
                            },
                            icon: loginCubit.passwordIcon,
                          ),
                          border: const OutlineInputBorder(),
                          onChanged: (String data) {},
                        ),
                        vSpace(40),
                        CustomMaterialBotton(
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              loginCubit.loginUser(
                                  username: userNameController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: state is LoginLoadingState
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                        ),
                        vSpace(),
                        RegisterOptions(
                          question: 'You don\'t have account',
                          action: 'REGISTER',
                          onPressed: () {
                            NavigationServices.navigateTo(
                                context, const RegisterScreen());
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum ToastStates { error, success }
