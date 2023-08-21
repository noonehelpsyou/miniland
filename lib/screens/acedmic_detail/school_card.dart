import 'package:flutter/material.dart';

class SchoolCard extends StatelessWidget {
  const SchoolCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0.1,
            blurRadius: 5,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            "https://source.unsplash.com/random/?avenger/",
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "Miniland English Boarding School.",
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
        subtitle: Text(
          "It is schhol with difference , we donot focus on qunatity we focused on quality.",
          style: TextStyle(color: Colors.black45),
        ),
      ),
    );
  }
}
