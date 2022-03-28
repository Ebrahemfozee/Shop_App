import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/models/favorites_model.dart';
import 'package:shop_app_new/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/cubit/states.dart';
import 'package:shop_app_new/shared/componants/componant.dart';
import 'package:shop_app_new/shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context , state){},
      builder: (context , state) {
        return ConditionalBuilder(
          condition: state is !ShopAppGetFavoritesLoadingState,
          builder:(context) => ListView.separated(
            itemBuilder: (context , index) =>  buildFavoritesItem(ShopAppCubit.get(context).favoritesModel!.data!.data![index].product!,context)  ,
            separatorBuilder: (context , index) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(height: 1,color: Colors.grey,),
            ),
            itemCount: ShopAppCubit.get(context).favoritesModel!.data!.data!.length,
          ) ,
          fallback: (context) => const Center(child: CircularProgressIndicator()),

        );
      },
    );
  }

}
