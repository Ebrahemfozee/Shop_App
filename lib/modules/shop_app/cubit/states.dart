import 'package:shop_app_new/models/change_favorites_model.dart';
import 'package:shop_app_new/models/login_model.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates{}
class ShopAppChangeBottomNAvState extends ShopAppStates{}
class ShopAppHomeDataLoadingState extends ShopAppStates{}
class ShopAppHomeDataSuccessState extends ShopAppStates{}
class ShopAppHomeDataErrorLoadingState extends ShopAppStates{
  final String error;

  ShopAppHomeDataErrorLoadingState(this.error);
}

class ShopAppCategoriesLoadingState extends ShopAppStates{}
class ShopAppCategoriesSuccessState extends ShopAppStates{}
class ShopAppCategoriesErrorLoadingState extends ShopAppStates{
  final String error;

  ShopAppCategoriesErrorLoadingState(this.error);
}

class ShopAppChangeFavoritesSuccessState extends ShopAppStates{
  final ChangeFavoritesModel model;

  ShopAppChangeFavoritesSuccessState(this.model);
}
class ShopAppChangeFavoritesState extends ShopAppStates{}
class ShopAppChangeFavoritesErrorState extends ShopAppStates{
  final String error;

  ShopAppChangeFavoritesErrorState(this.error);


}

class ShopAppGetFavoritesSuccessState extends ShopAppStates{}
class ShopAppGetFavoritesLoadingState extends ShopAppStates{}
class ShopAppGetFavoritesErrorLoadingState extends ShopAppStates{
  final String error;

  ShopAppGetFavoritesErrorLoadingState(this.error);
}

class ShopAppGetUserSuccessState extends ShopAppStates{

}



class ShopAppGetUserDataSuccessState extends ShopAppStates{
  final LoginModel loginModel;

  ShopAppGetUserDataSuccessState(this.loginModel);

}
class ShopAppGetUserDataLoadingState extends ShopAppStates{}
class ShopAppGetUserDataErrorLoadingState extends ShopAppStates{
  final String error;

  ShopAppGetUserDataErrorLoadingState(this.error);
}


class ShopAppGetUpdateUserDataSuccessState extends ShopAppStates{
  final LoginModel loginModel;

  ShopAppGetUpdateUserDataSuccessState(this.loginModel);
}
class ShopAppGetUpdateUserDataLoadingState extends ShopAppStates{}
class ShopAppGetUpdateUserDataErrorState extends ShopAppStates{
  final String error;

  ShopAppGetUpdateUserDataErrorState(this.error);}



