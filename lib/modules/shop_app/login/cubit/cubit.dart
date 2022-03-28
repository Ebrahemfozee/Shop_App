import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/models/login_model.dart';
import 'package:shop_app_new/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app_new/shared/network/remote/diohelper.dart';
import 'package:shop_app_new/shared/network/remote/endpoint.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void UserLogin({
  required String Email,
  required String Password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postDate(
        url: LOGIN,
        data: {
          'email':Email,
          'password':Password,
        },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true ;

  void ChangePasswordVisibilaty(){
    isPassword =!isPassword;
    suffix = isPassword? Icons.visibility_off_outlined:Icons.visibility_outlined ;

    emit(ShopChangePasswordVisibilatyState());
  }
}