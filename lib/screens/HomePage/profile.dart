import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../widgets/profile_menu_widget.dart';
import '../auth/login_screen.dart';
import '../home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String status = '';
  String profilePictureUrl = ''; // Store the URL of the profile picture
  bool isProfileExist = false;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
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
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }

    if (profilePictureUrl == "null") {
      isProfileExist = false;
    } else {
      isProfileExist = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.arrow_left)),
        title: Text("Profile", style: Theme.of(context).textTheme.headline4),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: isProfileExist
                              ? Image(
                                  image: NetworkImage(profilePictureUrl),
                                  fit: BoxFit.cover,
                                )
                              : SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: CircleAvatar(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(.5),
                                      radius: 100,
                                      child: Text(
                                        name.isNotEmpty ? name[0] : 'N/A',
                                        style: TextStyle(fontSize: 38),
                                      )),
                                )),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.redAccent),
                      child: IconButton(
                        onPressed: () {
                          _openBottomSheet(context);
                        },
                        icon: Icon(
                          CupertinoIcons.pencil,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(name, style: Theme.of(context).textTheme.headline4),
              Text(status, style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text("Edit Profile",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Settings", icon: Icons.settings, onPress: () {}),
              ProfileMenuWidget(
                  title: "Billing Details", icon: Icons.wallet, onPress: () {}),
              ProfileMenuWidget(
                  title: "User Management",
                  icon: Icons.verified_user_rounded,
                  onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information", icon: Icons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Logout?"),
                        content: Text("Are you sure, you want to Logout?"),
                        actions: [
                          TextButton(
                            onPressed: () => _signOut(context),
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('No'),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // After signing out, navigate back to the login screen (replace '/login' with your login screen route)
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  } catch (e) {
    // If sign out fails, handle the error (you can show a snackbar or dialog here)
    print('Error signing out: $e');
  }
}

void _openBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Pick from gallery.'),
              onTap: () {
                // Add your share functionality here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a picture.'),
              onTap: () {
                // Add your delete functionality here
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
