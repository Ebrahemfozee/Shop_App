import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/models/login_model.dart';
import 'package:shop_app_new/modules/shop_app/register/cubit/states.dart';
import 'package:shop_app_new/shared/network/remote/diohelper.dart';
import 'package:shop_app_new/shared/network/remote/endpoint.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postDate(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true ;

  void ChangePasswordVisibilaty(){
    isPassword =!isPassword;

    suffix = isPassword? Icons.visibility_off_outlined : Icons.visibility_outlined ;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}