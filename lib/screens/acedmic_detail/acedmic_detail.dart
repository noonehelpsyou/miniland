import 'package:flutter/material.dart';
import 'package:miniland/screens/acedmic_detail/school_card.dart';
import 'package:miniland/screens/acedmic_detail/teacherProfile.dart';
import 'package:miniland/screens/acedmic_detail/teacher_tile.dart';

class AcedmicDetail extends StatelessWidget {
  const AcedmicDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.redAccent,
          title: Text("Acedmic Details."),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        SliverToBoxAdapter(
            child: Column(
          children: [
            SchoolCard(),
            TabBarWidget(),
          ],
        )),
      ],
    ));
  }
}

class TabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Principles'),
              Tab(text: 'Teachers'),
              Tab(text: 'Stafs'),
            ],
          ),
          Container(
            height: 200,
            child: TabBarView(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      TeacherTile(
                          name: "Bikarna karki",
                          profession: "principle",
                          image:
                              "https://source.unsplash.com/random/?spiderman/"),
                      TeacherTile(
                          name: "Buddhi Nath Jha",
                          profession: "vice principle",
                          image:
                              "https://source.unsplash.com/random/?ironman/"),
                    ],
                  ),
                ),
                Center(child: Text('Tab 2 Content')),
                Center(child: Text('Tab 3 Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
