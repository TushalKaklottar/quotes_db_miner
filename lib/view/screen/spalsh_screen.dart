import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) {

    Timer(
        Duration(seconds: 2),
            () {
          Get.offNamed('/home');
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/logo.png",height: 150,),
            ),
        ],
      ),
    );
  }
}
