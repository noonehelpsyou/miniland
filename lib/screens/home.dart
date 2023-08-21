import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniland/screens/HomePage/Dues.dart';
import 'package:miniland/screens/HomePage/calendar.dart';
import 'package:miniland/screens/HomePage/community.dart';
import 'package:miniland/screens/HomePage/mainScreen.dart';
import 'package:miniland/screens/HomePage/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final screen = <Widget>[
      const MainScreen(),
      const DuesScreen(),
      const CommunityScreen(),
      EventCalendar(),
    ];

    // final items = <Widget>[
    //   const Icon(
    //     Icons.payment_rounded,
    //     size: 30,
    //     color: Colors.white,
    //   ),
    //   const Icon(CupertinoIcons.chat_bubble, size: 30, color: Colors.white),
    //   const Icon(Icons.home, size: 30, color: Colors.white),
    //   const Icon(CupertinoIcons.calendar, size: 30, color: Colors.white),
    //   const Icon(CupertinoIcons.person, size: 30, color: Colors.white),
    // ];

    return Scaffold(
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.redAccent,
        inactiveIconColor: Colors.redAccent,
        tabs: [
          TabData(iconData: CupertinoIcons.house_fill, title: "Home"),
          TabData(iconData: Icons.wallet, title: "Dues"),
          TabData(iconData: CupertinoIcons.chat_bubble_2_fill, title: "Community"),

          TabData(iconData: CupertinoIcons.calendar, title: "Calendar"),
        ],
        onTabChangedListener: (position) {
          setState(() {
            index = position;
          });
        },
      ),
      body: Center(child: screen[index]),
    );
  }
}
