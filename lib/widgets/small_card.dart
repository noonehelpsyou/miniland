import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final Color color1;
  final Color color2;
  final String text;
  final IconData icon;
  final VoidCallback onTap;
   SmallCard(
      {super.key,
        required this.onTap,
      required this.color1,
      required this.text,
      required this.color2,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double halfScreenWidth = (screenWidth / 2) - 16;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.all(8),
        width: halfScreenWidth,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.red[600],
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: const [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 35,
            ),
            Text(
              text,
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
