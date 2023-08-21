import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniland/screens/HomePage/profile.dart';
import 'package:miniland/screens/acedmic_detail/acedmic_detail.dart';
import 'package:miniland/screens/apply_leave.dart';
import 'package:miniland/screens/bus_screen/bus_screen.dart';
import 'package:miniland/screens/online_course/cousre.dart';
import 'package:miniland/widgets/card.dart';
import 'package:miniland/widgets/dot.dart';
import 'package:miniland/widgets/small_card.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/drawer.dart';
import '../auth/signup_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';
  String status = '';
  String profilePictureUrl = ''; // Store the URL of the profile picture
  bool isProfileExist = false;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    print(isProfileExist);
  }

  // Function to fetch user profile data from Firestore
  void fetchUserProfile() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      var userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userSnapshot.exists) {
        var userData = userSnapshot.data();
        setState(() {
          name = userData!['username'] ?? '';
          status = userData!['status'] ?? '';
          profilePictureUrl = userData['image'] ??
              ''; // Assuming you saved the profile picture URL in Firestore
          print(profilePictureUrl);
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }

    if (profilePictureUrl == "null" || profilePictureUrl.isEmpty) {
      isProfileExist = false;
    } else {
      isProfileExist = true;
    }
  }

  final controller = CarouselController();
  int activeIndex = 0;
  final urlImages = [
    "https://source.unsplash.com/random/?anime/",
    "https://source.unsplash.com/random/?school/",
    "https://source.unsplash.com/random/?marvel/",
    "https://source.unsplash.com/random/?hacking/",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 65,
            backgroundColor: Colors.redAccent,
            // pinned: false,
            floating: true,
            expandedHeight: 60,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                // Add your drawer open functionality here
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 1.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications, color: Colors.black38),
                  onPressed: () {
                    // Add your profile icon functionality here
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: isProfileExist
                      ? ClipOval(
                          child: Image(
                            image: NetworkImage(profilePictureUrl),
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        )
                      : SizedBox(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                            backgroundColor: Colors.redAccent.withOpacity(.5),
                            radius: 50,
                            child: Text(
                              name.isNotEmpty ? name[0] : 'N/A',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
              ),
            ],

            title: Text(
              "Miniland.",
              style: TextStyle(fontFamily: "medium", color: Colors.white),
            ),
            // Add any other properties to the SliverAppBar as needed
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CarouselSlider.builder(
                          itemCount: urlImages.length,
                          itemBuilder: (context, index, realIndex) {
                            final urlImage = urlImages[index];
                            return buildImage(urlImage, index);
                          },
                          options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              enlargeFactor: 0.2,
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 2),
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) =>
                                  setState(() => activeIndex = index)),
                        ),
                        const SizedBox(height: 12),
                        buildIndicator(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Notice",
                    textScaleFactor: 1.5,
                    style: TextStyle(fontFamily: "medium"),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyDot(color: Colors.black, height: 4, width: 10),
                    ],
                  ),
                  const SizedBox(width: 5),
                  const MyCard(),
                  const Text("More..."),
                  const SizedBox(height: 13),
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Discover.",
                        style: TextStyle(fontSize: 20, fontFamily: "medium"),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SmallCard(
                        color1: const Color(0xffB31312).withOpacity(0.5),
                        color2: const Color(0xffB04759),
                        icon: Icons.school_rounded,
                        text: "Acedmic Details",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AcedmicDetail()));
                        },
                      ),
                      SmallCard(
                        color1: Color(0xff8BACAA),
                        color2: Color(0xff84D2C5),
                        icon: Icons.payment_rounded,
                        text: "Fee Payment",
                        onTap: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SmallCard(
                        color1: const Color(0xff243A73).withOpacity(0.6),
                        color2: const Color(0xffA5BECC),
                        icon: Icons.bar_chart_rounded,
                        text: "Check Result",
                        onTap: () {},
                      ),
                      SmallCard(
                        color2: Color.fromARGB(255, 164, 168, 116),
                        color1: Color(0xffCC9C75),
                        icon: CupertinoIcons.calendar,
                        text: "Apply For Leave",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ApplyForLeaveScreen()));
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SmallCard(
                        color2: const Color(0xff468B97),
                        color1: const Color(0xff1D5B79).withOpacity(0.5),
                        icon: Icons.check,
                        text: "Attendence",
                        onTap: () {},
                      ),
                      SmallCard(
                        color2: const Color(0xffFF6969),
                        color1: const Color(0xffDB005B).withOpacity(0.5),
                        icon: CupertinoIcons.bus,
                        text: "Bus Route",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BusRoute()),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SmallCard(
                        color1: Color.fromARGB(255, 193, 157, 128),
                        color2: Color.fromARGB(255, 204, 197, 138),
                        icon: CupertinoIcons.book,
                        text: "Examination",
                        onTap: () {},
                      ),
                      SmallCard(
                        color2: Color.fromARGB(255, 157, 206, 168),
                        color1: Color.fromARGB(255, 132, 177, 128),
                        icon: CupertinoIcons.video_camera,
                        text: "Online Couses",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnlineCourse()),
                          );
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _signOut(context);
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
            dotWidth: 10,
            dotHeight: 5,
            activeDotColor: Color.fromARGB(255, 243, 33, 33)),
        activeIndex: activeIndex,
        count: urlImages.length,
      );
  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
          width: double.maxFinite,
        ),
      ),
    );

Future<void> _signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // After signing out, navigate back to the login screen (replace '/login' with your login screen route)
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  } catch (e) {
    // If sign out fails, handle the error (you can show a snackbar or dialog here)
    print('Error signing out: $e');
  }
}
