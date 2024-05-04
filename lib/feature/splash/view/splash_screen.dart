import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teldax/core/constants/app_assets.dart';
import 'package:teldax/core/constants/app_color.dart';
import 'package:teldax/feature/auth/view/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  RegisterScreen(),
          ));
    });
  }

  // your design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.logo,
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Wallet",
                style: TextStyle(
                    fontSize: 65,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const Text(
                "Money Transfer, Wallet & Finance UI Kit",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
