import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_flutter/core/utils/extensions.dart';
import 'package:shop_app_flutter/shared/constants.dart';

import '../../core/values/lang_keys.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> langs = [
      {'en': LangKeys.ENGLISH},
      {'ar': LangKeys.ARABIC}
    ];
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    context
                        .setLocale(langs[index].entries.first.key.toLocale());
                  },
                  title: Text(
                    langs[index].entries.first.value.tr(),
                    style: context.textTheme.labelMedium,
                  ),
                ),
            separatorBuilder: (context, index) => Constants.myDivider,
            itemCount: langs.length),
      ),
    );
  }
}
