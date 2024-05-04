import 'package:flutter/material.dart';
import 'package:teldax/core/constants/app_color.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String labelText;
  final Color bgColor;
  final Color textColor;
  final Function()? onPressed;
  final double width;
  final double height;
  final FontWeight fontWeight;
  final double fontSize;

  const CustomPrimaryButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
    this.bgColor = AppColor.primaryColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 56,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child:  Text(
            labelText,
            style: TextStyle(
                color: textColor, fontSize: fontSize, fontWeight: fontWeight),
          )),
    );
  }
}
