import 'package:flutter/material.dart';
import 'package:miniland/widgets/buttons.dart';

class MyAuth extends StatelessWidget {
  const MyAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 17),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "MiniLand",
                    textScaleFactor: 1.5,
                    style: TextStyle(fontFamily: "Poppins-bold"),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: const Column(
                        children: [
                        ],
                      ),
                    ),
const Column(
  children: [
    MyButton(
        image: "lib/images/search.png",
        text: "Continue with Google",
        color: Colors.white,
        textColor: Colors.black),
    SizedBox(height: 5),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("or continue with"),
      ],
    ),
    SizedBox(height: 5),
    MyButton(
      image: "lib/images/apple.png",
      text: "Continue with Apple",
      color: Colors.black,
      textColor: Colors.white,
    ),
  ],
),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
