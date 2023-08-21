import 'package:flutter/material.dart';

class DuesCardWidget extends StatelessWidget {
  final IconData icon;
  final String name;
   DuesCardWidget({super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.redAccent.withOpacity(0.1),
            ),
            child: Center(child: Icon(icon,color: Colors.redAccent,))),
        SizedBox(width: 10,),
        Text(name)
      ],
    );
  }
}
