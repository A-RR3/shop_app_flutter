import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/core/utils/navigation_services.dart';
import 'package:shop_app_flutter/modules/layout/shop_layout.dart';
import 'package:shop_app_flutter/modules/register/register_screen.dart';
import 'package:shop_app_flutter/shared/constants.dart';
import 'package:shop_app_flutter/shared/widgets/common_text_widget.dart';
import 'package:shop_app_flutter/shared/widgets/custom_material_botton_widget.dart';
import 'package:shop_app_flutter/shared/widgets/custom_text_form_field.dart';
import 'package:shop_app_flutter/shared/widgets/register_options_widget.dart';

import '../../core/utils/enums/toast_enum.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/validations.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  var loginFormKey = GlobalKey<FormState>();
  var userEmailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if (state is LoginSuccessState) {
            if (state.profileModel.status) {
              CacheHelper.setData(
                      key: 'token', value: state.profileModel.data?.token)
                  .then((value) {
                token = CacheHelper.getData(key: 'token');
                showToast(
                    meg: state.profileModel.message!,
                    toastState: ToastStates.success);
                NavigationServices.navigateTo(context, const ShopScreen(),
                    removeAll: true);
              });
            } else {
              showToast(
                  meg: state.profileModel.message!,
                  toastState: ToastStates.error);
            }
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
                        const CommonTextWidget(text: 'LOGIN'),
                        Constants.vSpace(),
                        Text(
                          'Discover a world of products at your fingertips. Login and start shopping.',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey[800]),
                        ),
                        Constants.vSpace(40),
                        CustomTextFormField(
                          controller: userEmailController,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) =>
                              validateIsEmpty(value, 'Please enter your email'),
                          hintText: 'User Email',
                          prefixIcon: Icons.email,
                          border: const OutlineInputBorder(),
                          focusNode: loginCubit.emailFocus,
                          onFieldSubmitted: (p0) => FocusScope.of(context)
                              .requestFocus(loginCubit.passwordFocus),
                          textInputAction: TextInputAction.next,
                        ),
                        Constants.vSpace(),
                        CustomTextFormField(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: !loginCubit.isPasswordShown,
                          validator: (value) => validateIsEmpty(
                              value, 'Please enter your password'),
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginCubit.showHidePassword(
                                  ChangePasswordVisibilityState());
                            },
                            icon: loginCubit.passwordIcon,
                          ),
                          border: const OutlineInputBorder(),
                          textInputAction: TextInputAction.done,
                          focusNode: loginCubit.passwordFocus,
                        ),
                        Constants.vSpace(40),
                        CustomMaterialBotton(
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              loginCubit.userLogin(
                                  email: userEmailController.text,
                                  password: passwordController.text);
                            }
                            FocusScope.of(context).unfocus();
                          },
                          child: state is LoginLoadingState
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'LOGIN',
                                  style: context.textTheme.labelSmall!
                                      .copyWith(color: Colors.white),
                                ),
                        ),
                        Constants.vSpace(),
                        RegisterOptions(
                          question: 'You don\'t have account',
                          action: 'REGISTER',
                          onPressed: () {
                            NavigationServices.navigateTo(
                                context, RegisterScreen(),
                                removeAll: true);
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
