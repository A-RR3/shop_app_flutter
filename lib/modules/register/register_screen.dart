import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/core/utils/navigation_services.dart';
import 'package:shop_app_flutter/modules/login/login_screen.dart';
import 'package:shop_app_flutter/shared/widgets/common_text_widget.dart';
import 'package:shop_app_flutter/shared/widgets/custom_material_botton_widget.dart';
import 'package:shop_app_flutter/shared/widgets/custom_text_form_field.dart';
import 'package:shop_app_flutter/shared/widgets/register_options_widget.dart';

import '../../core/utils/enums/toast_enum.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/validations.dart';
import '../../shared/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, RegisterStates state) {
          if (state is RegisterSuccessState) {
            if (state.profileModel.status) {
              CacheHelper.setData(
                      key: 'token', value: state.profileModel.data?.token)
                  .then((value) {
                NavigationServices.navigateTo(context, LoginScreen(),
                    removeAll: true);
              });
              showToast(
                  meg: state.profileModel.message!,
                  toastState: ToastStates.success);
            } else {
              showToast(
                  meg: state.profileModel.message!,
                  toastState: ToastStates.error);
            }
          }
        },
        builder: (BuildContext context, RegisterStates state) {
          var registerCubit = RegisterCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: registerFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonTextWidget(text: 'REGISTER'),
                          Constants.vSpace(),
                          Text(
                            'Register and start shopping.',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.grey[800]),
                          ),
                          Constants.vSpace(30),
                          CustomTextFormField(
                            controller: nameController,
                            hintText: 'Name',
                            prefixIcon: Icons.person,
                            textInputType: TextInputType.text,
                            validator: (value) => validateIsEmpty(
                                value, 'Please enter your name'),
                            onFieldSubmitted: (p0) => FocusScope.of(context)
                                .requestFocus(registerCubit.email),
                            textInputAction: TextInputAction.next,
                            focusNode: registerCubit.name,
                          ),
                          Constants.vSpace(),
                          CustomTextFormField(
                            controller: emailController,
                            hintText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) => validateIsEmpty(
                                value, 'Please enter your email'),
                            onFieldSubmitted: (p0) => FocusScope.of(context)
                                .requestFocus(registerCubit.password),
                            textInputAction: TextInputAction.next,
                            focusNode: registerCubit.email,
                          ),
                          Constants.vSpace(),
                          CustomTextFormField(
                            controller: passwordController,
                            hintText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            textInputType: TextInputType.visiblePassword,
                            validator: (value) => validateIsEmpty(
                                value, 'Please enter your password'),
                            obscureText: !registerCubit.isPasswordShown,
                            suffixIcon: IconButton(
                              onPressed: () {
                                registerCubit.showHidePassword(
                                    ChangePasswordVisibilityState());
                              },
                              icon: registerCubit.passwordIcon,
                            ),
                            onFieldSubmitted: (p0) => FocusScope.of(context)
                                .requestFocus(registerCubit.phone),
                            textInputAction: TextInputAction.next,
                            focusNode: registerCubit.password,
                          ),
                          Constants.vSpace(),
                          CustomTextFormField(
                            controller: phoneController,
                            hintText: 'Phone',
                            prefixIcon: Icons.phone,
                            textInputType: TextInputType.phone,
                            validator: (value) => validateIsEmpty(
                                value, 'Please enter your phone number'),
                            textInputAction: TextInputAction.done,
                            focusNode: registerCubit.phone,
                          ),
                          Constants.vSpace(40),
                          CustomMaterialBotton(
                            onPressed: () {
                              if (registerFormKey.currentState!.validate()) {
                                registerCubit.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                              FocusScope.of(context).unfocus();
                            },
                            child: state is RegisterLoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                          ),
                          Constants.vSpace(10),
                          RegisterOptions(
                              question: 'Already have an account ?',
                              action: 'LOGIN',
                              onPressed: () => NavigationServices.navigateTo(
                                  context, LoginScreen(),
                                  removeAll: true))
                        ],
                      ),
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
