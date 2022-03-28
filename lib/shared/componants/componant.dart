
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_new/models/favorites_model.dart';
import 'package:shop_app_new/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/login/login.dart';
import 'package:shop_app_new/shared/network/local/cash_helper.dart';
import 'package:shop_app_new/shared/style/colors.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? ontap,
  required String? Function(String?)? validate,
  required String text,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixpresed,
  bool isClickable = true,
  TextStyle? style,
}) =>
    TextFormField(
      style: style,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: ontap,
      validator: validate,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpresed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUppercase = true,
  double radius = 15.0,
  required Function()? function,
  required String text,
}) =>
    Container(
      height: 50.0,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: defaultColor,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

void showToast({required String text,required ToastStates state}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 4,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);


enum ToastStates {SUCCESS,ERROR,WARNING}

Color? chooseToastColor (ToastStates state)
{
  Color? color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color =  Colors.green;
    break;
    case ToastStates.WARNING:
      color = Colors.grey;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

void signOut (context){
  CashHelpers.removeData(key: 'token').then((value) {
    if (value) {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  });
}

String? token = '';

Widget buildFavoritesItem(model , context, {bool isOldPrice  = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(

          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: 130,
                height: 130,
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Expanded(
         // flex: 2,
          child: Column(
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.32),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: defaultColor,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice!.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.3,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context).ChangeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 12.0,
                      backgroundColor: ShopAppCubit.get(context).favorites[model.id]?? false
                          ? defaultColor
                          : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

