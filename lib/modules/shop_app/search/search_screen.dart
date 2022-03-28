import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app_new/shared/componants/componant.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit , SearchAppStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'Enter text to search';
                          }
                          return null;
                        },
                      onSubmit: (String text)
                      {
                        SearchCubit.get(context).getSearch(text);
                      },
                        text: 'Search',
                        prefix: Icons.search,
                    ),
                    const SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    const SizedBox(height: 10,),
                    if(state is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                        itemBuilder: (context , index) =>  buildFavoritesItem(SearchCubit.get(context).searchModel!.data!.data![index],context,isOldPrice: false)  ,
                        separatorBuilder: (context , index) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(height: 1,color: Colors.grey,),
                        ),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ) ,
          );
        },
      )
    );
      //SafeArea(child: Text('SearchScreen'));
  }
}
