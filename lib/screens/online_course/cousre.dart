import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:miniland/screens/home.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'constants.dart';
import 'models/category.dart';

class OnlineCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Courses",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.white)),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.notifications, color: Colors.black),
                onPressed: () {
                  // Add your profile icon functionality here
                },
              ),
            ),
          ],
          backgroundColor: Colors.redAccent,
        ),
        body: ListView.builder(
          itemCount: categories.length + 1, // Adding 1 for the first index
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     SvgPicture.asset("lib/images/flaticons/menu.svg"),
                    //     Image.asset("lib/images/flaticons/photo.png",
                    //         height: 50, width: 50),
                    //   ],
                    // ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hey Shahid,", style: kHeadingextStyle),
                        Text("Find a course you want to learn",
                            style: kSubheadingextStyle),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F7),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset("lib/images/flaticons/search.svg"),
                          SizedBox(width: 16),
                          Text(
                            "Search for anything",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFA0A5BD),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Category", style: kTitleTextStyle),
                        Text(
                          "See All",
                          style: kSubtitleTextSyule.copyWith(
                              color: Colors.redAccent),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              );
            } else {
              final categoryIndex = index - 1; // Adjusting for the header
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  height: 200,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 1.5,
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(categories[categoryIndex].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        categories[categoryIndex].name,
                        style: kTitleTextStyle,
                      ),
                      Text(
                        '${categories[categoryIndex].numOfCourses} Courses',
                        style: TextStyle(
                          color: kTextColor.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
