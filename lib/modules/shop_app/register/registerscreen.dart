import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_new/layout/shop_layout.dart';
import 'package:shop_app_new/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/register/cubit/cubit.dart';
import 'package:shop_app_new/modules/shop_app/register/cubit/states.dart';
import 'package:shop_app_new/shared/componants/componant.dart';
import 'package:shop_app_new/shared/network/local/cash_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {

              CashHelpers.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                print('1');
                token = state.loginModel.data!.token!;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ShopLayout()),
                );
              });
            } else {
              print(state.loginModel.message);

              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4!
                            .copyWith(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Text(
                            'Register now to browse our hot offers',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.black38, fontSize: 18),
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        text: 'User name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                        text: 'Email Address',
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        isPassword: ShopRegisterCubit
                            .get(context)
                            .isPassword,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                        },
                        text: 'Password',
                        prefix: Icons.lock,
                        suffix: ShopRegisterCubit
                            .get(context)
                            .suffix,
                        suffixpresed: () {
                          ShopRegisterCubit.get(context)
                              .ChangePasswordVisibilaty();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone number';
                          }
                        },
                        text: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) =>
                            defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'register',
                              isUppercase: true,
                            ),
                        fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
