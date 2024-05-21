import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/shared/constants.dart';
import 'package:shop_app_flutter/shared/widgets/common_text_widget.dart';
import 'package:shop_app_flutter/shared/widgets/custom_text_form_field.dart';

import '../favorites/favorite_item_widget.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit()..getSearchResult(''),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit searchCubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
                title: const CommonTextWidget(text: 'Search'),
                foregroundColor: Colors.black),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: searchController,
                    textInputType: TextInputType.text,
                    hintText: 'search',
                    prefixIcon: Icons.search,
                    onChanged: (value) {
                      searchCubit.cancelRequestToken;
                      searchCubit.getSearchResult(searchController.text);
                    },
                  ),
                  Constants.vSpace(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => FavoriteItem(
                          product: searchCubit.searchList![index],
                          search: true,
                        ),
                        separatorBuilder: (context, index) =>
                            Constants.myDivider,
                        itemCount: searchCubit.searchList!.length,
                      ),
                    )
                  else if (state is SearchLoadingState)
                    const Center(child: CircularProgressIndicator())
                  else
                    const Text(''),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
