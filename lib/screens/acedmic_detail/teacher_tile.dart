import 'package:flutter/material.dart';
import 'package:miniland/screens/acedmic_detail/teacherProfile.dart';

class TeacherTile extends StatelessWidget {
  final String name;
  final String profession;
  final String image;

  TeacherTile(
      {super.key,
      required this.name,
      required this.profession,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeacherProfile(
                      image: image,
                      name: name,
                      profession: profession,
                    )));
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          image,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      subtitle: Text(
        profession,
        style: TextStyle(color: Colors.black45),
      ),
    );
  }
}
