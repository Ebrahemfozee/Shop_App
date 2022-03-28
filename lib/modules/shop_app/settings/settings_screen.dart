import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/cubit/states.dart';
import 'package:shop_app_new/shared/componants/componant.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var model = ShopAppCubit.get(context).userDataModel;
        if (model != null) {
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
        }

        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).userDataModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is ShopAppGetUpdateUserDataLoadingState)
                        LinearProgressIndicator(),
                      const SizedBox(height: 20,),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name must not be empty';
                          }
                          return null;
                        },
                        text: 'User name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        text: 'Email Address',
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                        text: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopAppCubit.get(context).getUpdateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }else
                            print ('3');
                        },
                        text: 'Update',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
