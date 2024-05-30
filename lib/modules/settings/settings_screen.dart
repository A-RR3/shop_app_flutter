import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/core/utils/enums/toast_enum.dart';
import 'package:shop_app_flutter/core/utils/extensions.dart';
import 'package:shop_app_flutter/core/utils/navigation_services.dart';
import 'package:shop_app_flutter/core/utils/validations.dart';
import 'package:shop_app_flutter/shared/widgets/custom_material_botton_widget.dart';
import 'package:shop_app_flutter/shared/widgets/custom_text_form_field.dart';

import '../../core/values/constants.dart';
import '../../core/values/lang_keys.dart';
import '../../shared/constants.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import 'language_screen.dart';

class SettingsScreen extends StatelessWidget {
  GlobalKey<FormState> settingsFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {
        if (state is ShopUpdateProfileDataSuccessState) {
          if (state.profile.status) {
            showToast(
                meg: state.profile.message, toastState: ToastStates.success);
            nameController.text = state.profile.data!.name;
            emailController.text = state.profile.data!.email;
            phoneController.text = state.profile.data!.phone;
          } else {
            showToast(
                meg: state.profile.message, toastState: ToastStates.error);
          }
        }
      },
      builder: (BuildContext context, ShopStates state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        if (state is! ShopUpdateProfileDataLoadingState ||
            state is! ShopUpdateProfileDataSuccessState) {
          nameController.text = shopCubit.profileModel!.data!.name;
          emailController.text = shopCubit.profileModel!.data!.email;
          phoneController.text = shopCubit.profileModel!.data!.phone;
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: settingsFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is ShopUpdateProfileDataLoadingState)
                    const LinearProgressIndicator(),
                  Constants.vSpace(),
                  CustomTextFormField(
                    controller: nameController,
                    hintText: LangKeys.NAME.tr(),
                    prefixIcon: Icons.person,
                    textInputType: TextInputType.text,
                    validator: (value) =>
                        validateIsEmpty(value, LangKeys.ENTER_YOUR_NAME.tr()),
                  ),
                  Constants.vSpace(),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: LangKeys.EMAIL,
                    prefixIcon: Icons.email_outlined,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) =>
                        validateIsEmpty(value, LangKeys.ENTER_EMAIL.tr()),
                  ),
                  Constants.vSpace(),
                  CustomTextFormField(
                    controller: phoneController,
                    hintText: LangKeys.PHONE.tr(),
                    prefixIcon: Icons.phone,
                    textInputType: TextInputType.phone,
                    validator: (value) => validateIsEmpty(
                        value, LangKeys.ENTER_PHONE_NUMBER.tr()),
                  ),
                  Constants.vSpace(),
                  CustomMaterialBotton(
                    onPressed: () {
                      shopCubit.signOut(context);
                      FocusScope.of(context).unfocus();
                    },
                    child: Text(
                      LangKeys.LOGOUT.tr(),
                      style: context.textTheme.labelSmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Constants.vSpace(),
                  CustomMaterialBotton(
                    onPressed: () {
                      if (settingsFormKey.currentState!.validate()) {
                        shopCubit.updateProfileData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }
                      FocusScope.of(context).unfocus();
                    },
                    child: Text(
                      LangKeys.UPDATE.tr(),
                      style: context.textTheme.labelSmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Constants.vSpace(),
                  CustomMaterialBotton(
                    onPressed: () => NavigationServices.navigateTo(
                        context, LanguageScreen()),
                    child: Text(
                      LangKeys.LANGUAGE.tr(),
                      style: context.textTheme.labelSmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Constants.vSpace()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
