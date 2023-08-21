import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniland/screens/home.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();
TextEditingController usernameController = TextEditingController();

//confirmpassword validator
String? _confirmPasswordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  // Check if the confirmed password matches the original password
  if (value != passwordController.text) {
    return 'Passwords do not match';
  }

  return null; // Return null if the input is valid
}

//username Validator
String? _usernameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a username';
  }

  // Check if the username contains any special characters
  if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>0-9]'))) {
    return 'Username cannot contain special characters or digits';
  }

  return null; // Return null if the input is valid
}

//-password validator
String? _passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }

  // Password length should be at least 8 characters
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }

  // Password must contain at least one uppercase letter
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  }

  // Password must contain at least one special character
  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Password must contain at least one special character';
  }

  // Password must contain alphanumeric characters
  if (!value.contains(RegExp(r'[a-zA-Z0-9]'))) {
    return 'Password must contain alphanumeric characters';
  }

  return null; // Return null if the input is valid
}

//email validator
String? _emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }

  // Check if the email is in a valid format using a regular expression
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email';
  }

  return null; // Return null if the input is valid
}

//class  validator
String? _classValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select a class';
  }
  if (value == 'Select Class') {
    return 'Please select a valid class';
  }
  return null; // Return null if the input is valid
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSigningUp =
      false; // Variable to control the visibility of the circular progress indicator
  // Initial Selected Value
  String dropdownvalue = 'Select Class';
  bool _isObsecured = false;

  // List of items in our dropdown menu
  var items = [
    "Select Class",
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  @override
  Widget build(BuildContext context) {
    UserCredential? userCredential;
    //show message dilog

    void showMessage(String message, String title) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
    //signup method

    Future<void> _signupWithEmailAndPassword() async {
      try {
        setState(() {
          _isSigningUp = true; // Show the circular progress indicator
        });

        final email = emailController.text;
        final password = passwordController.text;
        final username = usernameController.text;
        final selectedClass = dropdownvalue;

        // Call the Firebase API to create a new user with email and password
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        setState(() {
          _isSigningUp = false; // Hide the circular progress indicator
        });

        // If signup is successful, save additional user data in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'email': email,
          'username': username,
          'selectedClass': selectedClass,
          'fcmToken': "",
          'status': "student",
          'image': "null"
          // Add other user data if needed
        });

        // If signup is successful, navigate to the home screen (replace this with your home screen route)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isSigningUp = false; // Hide the circular progress indicator
        });

        // Handle the specific exception for 'email-already-in-use'
        if (e.code == "invalid-email") {
          showMessage("Ohoo!", "Email Already Exists");
        }
        if (e.code == 'email-already-in-use') {
          showMessage("Ohoo!", "Email Already Exists");
        } else {
          showMessage('Error occurred',
              'Error'); // Replace this with your custom error message function
        }
      } catch (e) {
        setState(() {
          _isSigningUp = false; // Hide the circular progress indicator
        });

        showMessage('Error occurred',
            'Error'); // Replace this with your custom error message function
      }
    }

    void setObsecured() {
      setState(() {
        _isObsecured = !_isObsecured;
      });
    }

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //top

                Image(
                  image:
                      const AssetImage("lib/images/onboarding_images/one.png"),
                  height: size.height * 0.2,
                ),
                const Text(
                  "Lets Start!",
                  style: TextStyle(fontFamily: "Poppins-bold", fontSize: 23),
                ),
                const Text(
                  "Lets begin the new journey..",
                  style: TextStyle(fontFamily: "medium"),
                ),

                //form

                Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                              controller: usernameController,
                              validator: _usernameValidator,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                labelText: "Username",
                                hintText: "Username",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              )),
                          const SizedBox(height: 10),
                          TextFormField(
                              controller: emailController,
                              validator: _emailValidator,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.mail_outline_rounded),
                                  labelText: "Email",
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100)))),
                          const SizedBox(height: 15),
                          TextFormField(
                              obscureText: _isObsecured,
                              validator: _passwordValidator,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.fingerprint_rounded),
                                  labelText: "Password",
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  suffixIcon: IconButton(
                                    onPressed: setObsecured,
                                    icon: _isObsecured
                                        ? Icon(CupertinoIcons.eye_slash_fill)
                                        : Icon(CupertinoIcons.eye_fill),
                                  ))),
                          const SizedBox(height: 10),
                          TextFormField(
                              obscureText: _isObsecured,
                              validator: _confirmPasswordValidator,
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(CupertinoIcons.lock),
                                  labelText: "Confirm Password",
                                  hintText: " Confirm Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  suffixIcon: IconButton(
                                    onPressed: setObsecured,
                                    icon: _isObsecured
                                        ? Icon(CupertinoIcons.eye_slash_fill)
                                        : Icon(CupertinoIcons.eye_fill),
                                  ))),
                          const SizedBox(height: 10),
                          Container(
                            child: DropdownButtonFormField(
                              validator: _classValidator,
                              // Initial Value
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.class_,
                                        color: Colors
                                            .black, // Customize the icon color
                                      ),
                                      SizedBox(
                                          width:
                                              10), // Add spacing between icon and text
                                      Text(
                                        items,
                                        style: TextStyle(
                                          color: Colors
                                              .black, // Customize the text color
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                hintText: "Select class",
                                labelText: 'Class',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        100)), // Add border around the DropdownButton
                              ),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.maxFinite,
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // Background color
                                onPrimary: Colors.white,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _signupWithEmailAndPassword();
                                }
                              },
                              child: _isSigningUp
                                  ? CircularProgressIndicator() // Show circular progress indicator
                                  : Text('Submit'),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Alredy have an account?",
                                style: TextStyle(
                                    fontFamily: "medium", fontSize: 13),
                              ),
                              // TextButton(
                              //   onPressed: SignUpScreen , child: child),

                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
