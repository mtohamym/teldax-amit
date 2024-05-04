import 'package:flutter/material.dart';
import 'package:teldax/core/constants/app_color.dart';

class CustomTextFormField extends StatelessWidget {

  const CustomTextFormField(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.keyboardType});

  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.grey,

        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        style: const TextStyle(
          color: AppColor.blueDark,
          fontSize: 14,
          fontWeight: FontWeight.w100
        ),
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColor.grey,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColor.red,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorStyle: const TextStyle(
            color: AppColor.red,
            fontSize: 12,
            fontWeight: FontWeight.w100
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: AppColor.grey20,
            fontSize: 14,
            fontWeight: FontWeight.w100
          ),

        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }
}
