import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/core/utils/navigation_services.dart';
import 'package:shop_app_flutter/core/values/local_storage_keys.dart';
import 'package:shop_app_flutter/modules/login/login_screen.dart';
import 'package:shop_app_flutter/shared/widgets/common_text_widget.dart';
import 'package:shop_app_flutter/shared/widgets/custom_material_botton_widget.dart';
import 'package:shop_app_flutter/shared/widgets/custom_text_form_field.dart';
import 'package:shop_app_flutter/shared/widgets/register_options_widget.dart';

import '../../core/utils/enums/toast_enum.dart';
import '../../core/utils/validations.dart';
import '../../core/values/constants.dart';
import '../../core/values/lang_keys.dart';
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
                      key: LocalStorageKeys.ACCESS_TOKEN,
                      value: state.profileModel.data?.token)
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
                          CommonTextWidget(text: LangKeys.REGISTER.tr()),
                          Constants.vSpace(),
                          Text(
                            LangKeys.REGISTER_OPENING_STATEMENT.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.grey[800]),
                          ),
                          Constants.vSpace(30),
                          CustomTextFormField(
                            controller: nameController,
                            hintText: LangKeys.NAME.tr(),
                            prefixIcon: Icons.person,
                            textInputType: TextInputType.text,
                            validator: (value) => validateIsEmpty(
                                value, LangKeys.ENTER_YOUR_NAME.tr()),
                            onFieldSubmitted: (p0) => FocusScope.of(context)
                                .requestFocus(registerCubit.email),
                            textInputAction: TextInputAction.next,
                            focusNode: registerCubit.name,
                          ),
                          Constants.vSpace(),
                          CustomTextFormField(
                            controller: emailController,
                            hintText: LangKeys.EMAIL.tr(),
                            prefixIcon: Icons.email_outlined,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) => validateIsEmpty(
                                value, LangKeys.ENTER_EMAIL.tr()),
                            onFieldSubmitted: (p0) => FocusScope.of(context)
                                .requestFocus(registerCubit.password),
                            textInputAction: TextInputAction.next,
                            focusNode: registerCubit.email,
                          ),
                          Constants.vSpace(),
                          CustomTextFormField(
                            controller: passwordController,
                            hintText: LangKeys.PASSWORD.tr(),
                            prefixIcon: Icons.lock_outline,
                            textInputType: TextInputType.visiblePassword,
                            validator: (value) => validateIsEmpty(
                                value, LangKeys.ENTER_PASSWORD.tr()),
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
                            hintText: LangKeys.PHONE.tr(),
                            prefixIcon: Icons.phone,
                            textInputType: TextInputType.phone,
                            validator: (value) => validateIsEmpty(
                                value, LangKeys.ENTER_PHONE_NUMBER.tr()),
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
                                : Text(
                                    LangKeys.REGISTER.tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                          ),
                          Constants.vSpace(10),
                          RegisterOptions(
                              question: LangKeys.ALREADY_HAVE_ACCOUNT.tr(),
                              action: LangKeys.LOGIN.tr(),
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
