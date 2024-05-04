import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teldax/core/widgets/primary_custom_form_field.dart';
import 'package:teldax/feature/auth/view/login_screen.dart';
import 'package:teldax/feature/auth/view_model/auth_cubit.dart';

import '../../../core/widgets/custom_primary_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();

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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text("Error"),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
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
                          "Register",
                          style: TextStyle(
                              fontSize: 44, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                          labelText: "Full Name",
                          controller: authCubit.fullNameController,
                          keyboardType: TextInputType.name,
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
                        CustomTextFormField(
                          labelText: "Confirm Password",
                          controller: authCubit.confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        CustomTextFormField(
                          labelText: "Phone Number",
                          controller: authCubit.phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        CustomPrimaryButton(
                          labelText: "Register",
                          onPressed: () {
                            authCubit.validateData();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LoginScreen()));
                              },
                              child: const Text("Login"),
                            ),
                          ],
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
