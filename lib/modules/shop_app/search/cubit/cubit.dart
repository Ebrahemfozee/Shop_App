
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/models/search_model.dart';
import 'package:shop_app_new/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app_new/shared/componants/componant.dart';
import 'package:shop_app_new/shared/network/remote/diohelper.dart';
import 'package:shop_app_new/shared/network/remote/endpoint.dart';

class SearchCubit extends Cubit<SearchAppStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearch(String data){
    emit(SearchLoadingState());

    DioHelper.postDate(
        url: SEARCH ,
        token: token,
        data:{
          'text':data,
        } ,
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState(error.toString()));
    });
  }
}