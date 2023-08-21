import 'dart:async';

import 'package:flutter/material.dart';
import 'package:miniland/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "MiniLand",
                    textScaleFactor: 2,
                    style: TextStyle(fontFamily: "Poppins-bold"),
                  ),
                  Text(".",
                      textScaleFactor: 2,
                      style: TextStyle(
                          color: Colors.red, fontFamily: "Poppins-bold")),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Powered by"),
                Text(
                  " Pseudo Web.",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
