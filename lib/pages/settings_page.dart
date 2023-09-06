import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MySettings extends StatelessWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade300,
      body: LottieBuilder.asset(
        "assets/working.json",
        fit: BoxFit.fill,
      ),
    );
  }
}
