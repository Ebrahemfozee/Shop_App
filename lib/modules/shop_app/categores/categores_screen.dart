import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/models/categories_model.dart';
import 'package:shop_app_new/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/cubit/states.dart';

class CategoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit , ShopAppStates>(
      listener: (context , state){},
      builder: (context , state){
        return ListView.separated(
          itemBuilder: (context,index) => buildCatItem(ShopAppCubit.get(context).categoriesModel!.data!.data![index],),
          separatorBuilder: (context , index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(height: 1,color: Colors.grey,),
          ),
          itemCount: ShopAppCubit.get(context).categoriesModel!.data!.data!.length,
        );
      },

    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: [
        Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Text(
                '${model.name}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                ),

              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ],
    ),
  );

}
