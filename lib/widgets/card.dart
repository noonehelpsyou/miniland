import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      width: size.width,
      color: Colors.white,
      child: Card(
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80",
                  width: 120,
                  height: size.height / 6 - 55, // Set the height dynamically
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: (size.width) - 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Important Notice.",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "medium",
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      width: size.width,
                      height: (size.height / 6) - 53,
                      child: const Text(
                        "It is clarify to all the students to come scholl regularly jhdsgh gdufsgj xhdjghd f hfgdiufhyg udghfud fgudfhg gdiuhgiudh dkghidfgi dudgfud iuhdfig dghkdh gdfghdjfhg",
                        maxLines: 3,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
