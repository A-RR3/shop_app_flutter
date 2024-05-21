import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/modules/search/cubit/search_states.dart';
import 'package:shop_app_flutter/shared/network/remote/dio_helper.dart';

import '../../../domain/models/product_model.dart';
import '../../../domain/models/search_model.dart';
import '../../../shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<ProductModel>? searchList;
  SearchModel? searchModel;
  CancelToken cancelToken = CancelToken();

  void getSearchResult(String? value) {
    emit(SearchLoadingState());
    DioHelper.postData(
            url: PRODUCTS_SEARCH,
            data: {'text': value},
            cancelToken: cancelToken)
        .then((res) {
      searchModel = SearchModel.fromJson(res.data);
      searchList = searchModel?.data!.data;
      emit(SearchSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SearchErrorState());
    });
  }

  void cancelRequestToken() {
    cancelToken.cancel('Cancelled');
    cancelToken = CancelToken();
  }
}
