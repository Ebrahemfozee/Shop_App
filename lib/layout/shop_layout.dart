import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/cubit/states.dart';
import 'package:shop_app_new/modules/shop_app/login/login.dart';
import 'package:shop_app_new/modules/shop_app/search/search_screen.dart';
import 'package:shop_app_new/shared/network/local/cash_helper.dart';

class ShopLayout extends StatelessWidget {
  //var cubit = ShopAppCubit.get(context);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Test',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    size: 28.0,
                  ),
                )
              ],
            ),
            body: ShopAppCubit.get(context)
                .bottomScreen[ShopAppCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int ind) {
                ShopAppCubit.get(context).changeBottom(ind);
              },
              currentIndex: ShopAppCubit.get(context).currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.apps,
                    ),
                    label: 'Categores'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                    ),
                    label: 'Settings'),
              ],
            ),
          );
        });
  }
}
