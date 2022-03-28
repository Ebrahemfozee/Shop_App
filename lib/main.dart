import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app_new/layout/shop_layout.dart';
import 'package:shop_app_new/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/cubit/states.dart';
import 'package:shop_app_new/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/login/login.dart';
import 'package:shop_app_new/shared/componants/componant.dart';
import 'package:shop_app_new/shared/const/blocobserver.dart';
import 'package:shop_app_new/shared/network/local/cash_helper.dart';
import 'package:shop_app_new/shared/network/remote/diohelper.dart';
import 'package:shop_app_new/shared/style/colors.dart';
import 'package:shop_app_new/shared/style/themes.dart';

import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CashHelpers.init();
  Widget widget;
  bool onBoarding = CashHelpers.getData(key: 'onBoarding');

  if(token != null){
    token = await CashHelpers.getData(key: 'token');
  }else return  null;

  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: false,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  MyApp({this.isDark, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopAppCubit()..getHome()..getCategories()..getFavorites()..getUserData(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context,  state) {
          return   MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: defaultColor,
              appBarTheme: const AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                iconTheme: IconThemeData(color:Colors.black ,),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              bottomNavigationBarTheme:const BottomNavigationBarThemeData(
                type:  BottomNavigationBarType.fixed,
                selectedItemColor: defaultColor,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
            //onBoarding! ? LoginScreen() : OnBoardingScreen(),
            //false ? LoginScreen()  :  OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
