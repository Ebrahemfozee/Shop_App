import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/models/categories_model.dart';
import 'package:shop_app_new/models/change_favorites_model.dart';
import 'package:shop_app_new/models/favorites_model.dart';
import 'package:shop_app_new/models/home_model.dart';
import 'package:shop_app_new/models/login_model.dart';
import 'package:shop_app_new/modules/shop_app/categores/categores_screen.dart';
import 'package:shop_app_new/modules/shop_app/cubit/states.dart';
import 'package:shop_app_new/modules/shop_app/favorates/favorates_screen.dart';
import 'package:shop_app_new/modules/shop_app/products/products_screen.dart';
import 'package:shop_app_new/modules/shop_app/search/search_screen.dart';
import 'package:shop_app_new/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_app_new/shared/componants/componant.dart';
import 'package:shop_app_new/shared/network/remote/diohelper.dart';
import 'package:shop_app_new/shared/network/remote/endpoint.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoresScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    // if(index == 0)
    //   getHome();
    // if(index ==1)
    //   getCategories();
    emit(ShopAppChangeBottomNAvState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favorites = {};

  void getHome() {
    emit(ShopAppHomeDataLoadingState());
    DioHelper.getDate(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners![0]);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopAppHomeDataSuccessState());
    }).catchError((error) {
      emit(ShopAppHomeDataErrorLoadingState(error.toString()));
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopAppCategoriesLoadingState());
    DioHelper.getDate(
      url: Get_Categories,
    ).then((value) {
      print(1);
      categoriesModel = CategoriesModel.fromjsomn(value.data);
      emit(ShopAppCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopAppCategoriesErrorLoadingState(error.toString()));
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel ;

  void ChangeFavorites(int? productId) {

    favorites[productId] =! favorites[ productId ?? false]!;
    emit(ShopAppChangeFavoritesState());

    DioHelper.postDate(
      url: FAVORITES,
      token: token,
      data: {
        'product_id' : productId ,
      },
    )
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      print(value.data.toString());
      if(changeFavoritesModel!.status == false)
        {
          favorites[productId] =!  favorites[ productId ?? false]!;
        }else
          {
            getFavorites();
          }
          emit(ShopAppChangeFavoritesSuccessState(changeFavoritesModel!));
    })
        .catchError((error) {
      favorites[productId] =! favorites[ productId ?? false]!;
      emit(ShopAppChangeFavoritesErrorState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopAppGetFavoritesLoadingState());
    DioHelper.getDate(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopAppGetFavoritesSuccessState());
    }).catchError((error) {
      emit(ShopAppGetFavoritesErrorLoadingState(error.toString()));
      print(error.toString());
    });
  }


  LoginModel? userDataModel;
  void getUserData() {
    emit(ShopAppGetUserDataLoadingState());
    DioHelper.getDate(
      url: PROFILE,
      token: token,
    ).then((value) {
      userDataModel = LoginModel.fromJson(value.data);
      emit(ShopAppGetUserDataSuccessState(userDataModel!));
    }).catchError((error) {
      emit(ShopAppGetUserDataErrorLoadingState(error.toString()));
      print(error.toString());
    });
  }

  void getUpdateUserData({
  required String? name,
  required String? email,
  required String? phone,
})
{
    emit(ShopAppGetUpdateUserDataLoadingState());
    DioHelper.putDate(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userDataModel = LoginModel.fromJson(value.data);
      emit(ShopAppGetUpdateUserDataSuccessState(userDataModel!));
    }).catchError((error) {
      emit(ShopAppGetUpdateUserDataErrorState(error.toString()));
      print(error.toString());
    });
  }
}
