import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teldax/core/widgets/custom_primary_button.dart';
import 'package:teldax/core/widgets/primary_custom_form_field.dart';
import 'package:teldax/feature/credit_card/view_model/credit_card_cubit.dart';

import '../../home_screen/view/home_screen.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditCardCubit(),
      child: BlocConsumer<CreditCardCubit, CreditCardState>(
        listener: (context, state) {
          if (state is CreditCardAdded) {
            Navigator.pop(context);
          }
          if (state is CreditCardError) {
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

          if (state is CreditCardLoading) {
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
        },
        builder: (context, state) {
          CreditCardCubit cubit = CreditCardCubit().get(context);
          return Scaffold(
            body: SafeArea(
                child: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 41),
                  child: Column(
                    children: [
                      Text('Add Card Screen'),
                      CustomTextFormField(
                          labelText: "Card Number",
                          controller: cubit.cardNumberController,
                          keyboardType: TextInputType.number),
                      CustomTextFormField(
                        labelText: "Card Holder Name",
                        controller: cubit.cardHolderNameController,
                        keyboardType: TextInputType.name,
                      ),
                      CustomTextFormField(
                          labelText: "Expiry Date",
                          controller: cubit.expiryDateController,
                          keyboardType: TextInputType.datetime),
                      CustomTextFormField(
                          labelText: "CVV",
                          controller: cubit.cvvController,
                          keyboardType: TextInputType.number),
                      CustomTextFormField(
                          labelText: "Balance",
                          controller: cubit.balanceController,
                          keyboardType: TextInputType.number),
                      CustomPrimaryButton(
                          labelText: "Add Card",
                          onPressed: () {
                            print("object");
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.addCard();
                            }
                          }),
                      // skip to hme screen text and inkwell
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Skip to Home Screen',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (route) => false);
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
