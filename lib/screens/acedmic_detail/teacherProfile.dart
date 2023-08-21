import 'package:flutter/material.dart';

class TeacherProfile extends StatelessWidget {
  final String name;
  final String profession;
  final String image;

  TeacherProfile(
      {Key? key,
      required this.name,
      required this.profession,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            Container(
              height: 250,
              color: Colors.redAccent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Teacher Profile",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    Container()
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 20, // Align Container 2 to the right edge of the screen
              left: 20,
              child: Container(
                height: 300,
                width: size.width, // Adjusted width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0.1,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          image,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      name,
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      profession,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                      width: size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your onPressed logic here
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('Contact'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Flexible(
                        child: Text(
                          maxLines: 2,
                          "Simple Dummy text hsudcghus ysudh ishydvi iysdfihs fyusdhfs ivysd viusdyv sdiysikv sniuvysik",
                          style: TextStyle(
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 390,
              right: 20,
              left: 20,
              bottom: 10,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                      offset: Offset(1, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount:
                      10, // Change this number to the desired number of list items
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ListTile(
                        title: Text(
                          'Class',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    } else {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "https://source.unsplash.com/random/?avenger/",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text('List Tile $index'),
                        subtitle: Text('Subtitle for List Tile $index'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
