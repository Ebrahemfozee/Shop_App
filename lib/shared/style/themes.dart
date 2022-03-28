import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app_new/shared/style/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('191a1b'),
  appBarTheme:  AppBarTheme(
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('191a1b'),
        statusBarIconBrightness: Brightness.light),
    backgroundColor: HexColor('191a1b'),
    titleTextStyle:  const TextStyle(
      color: Colors.white,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   type: BottomNavigationBarType.fixed,
    //   selectedItemColor: Colors.red,
    //   unselectedItemColor: Colors.grey,
    //   backgroundColor: Colors.black12,
    // ),
    //fontFamily: 'Roboto',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),


  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type:  BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    backgroundColor: HexColor('312128'),
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  textTheme:const  TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

);