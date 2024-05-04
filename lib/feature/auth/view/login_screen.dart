import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teldax/core/widgets/custom_primary_button.dart';
import 'package:teldax/core/widgets/primary_custom_form_field.dart';
import 'package:teldax/feature/credit_card/view/add_card_screen.dart';

import '../view_model/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Loading"),
                  content: Row(
                    children: [
                      Text("Please wait..."),
                      CupertinoActivityIndicator(),
                    ],
                  ),
                );
              },
            );
          }
          if (state is AuthFail) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Password or email is incorrect!"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
          if (state is AuthSuccess) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCardScreen(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          AuthCubit authCubit = AuthCubit().get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 41),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: authCubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 93,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 44, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                          labelText: "Email",
                          controller: authCubit.emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomTextFormField(
                          labelText: "Password",
                          controller: authCubit.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        CustomPrimaryButton(
                          labelText: "Login",
                          onPressed: () {
                            if (authCubit.formKey.currentState!.validate()) {
                              authCubit.loginWithEmailAndPassword();
                            }
                          },
                        ),
                      ],
                    ),
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
