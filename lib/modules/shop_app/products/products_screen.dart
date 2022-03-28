import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/models/categories_model.dart';
import 'package:shop_app_new/models/home_model.dart';
import 'package:shop_app_new/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/cubit/states.dart';
import 'package:shop_app_new/shared/componants/componant.dart';
import 'package:shop_app_new/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is ShopAppChangeFavoritesSuccessState)
        {
          if(state.model.status == false)
          {
            showToast(text: state.model.message!, state: ToastStates.ERROR );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).homeModel != null && ShopAppCubit.get(context).categoriesModel != null,
          builder: (context) =>
              productsBuilder(ShopAppCubit.get(context).homeModel , ShopAppCubit.get(context).categoriesModel,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel,context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners!.map((e) => Image
                (
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),).toList(),
              options: CarouselOptions(
                height: 200,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(
                  seconds: 1,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index) => buildCategories(categoriesModel!.data!.data![index]),
                        separatorBuilder:(context,index)=>SizedBox(width: 10.0,) ,
                        itemCount: categoriesModel!.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
               physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1 / 1.75,
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.products!.length,
                  (index) => buildGridProduct(model.data!.products![index],context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategories(DataModel? model )=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Image(
          image: NetworkImage('${model!.image}'),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
      ),
      Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.65),
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          width: 100,
          height: 25,

          child: Text(
            '${model.name}',
            style: TextStyle(color: Colors.white,
              fontSize: 18,

            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,

          )),
    ],
  );

  Widget buildGridProduct(Products model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 3.0),
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(height: 1,),
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.32),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price!.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: defaultColor,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice!.round()}',
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
                          backgroundColor: ShopAppCubit.get(context).favorites[model.id] !? defaultColor : Colors.grey,
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
      );
}
