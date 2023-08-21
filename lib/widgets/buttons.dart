import 'package:flutter/material.dart';
import 'package:miniland/screens/home.dart';

class MyButton extends StatelessWidget {

  final String image;
  final String text;
  final Color color;
  final Color textColor;
  const MyButton({super.key, required this.image , required this.text, required this.color, required this.textColor});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: InkWell(
          onTap: () {onLogin(context);},
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical:10),
            child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Image.asset(
                      image,
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 10),
                     Text(
                      text,
                      style: TextStyle(color: textColor, fontFamily: "medium"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLogin(BuildContext context) {
Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
}
}
