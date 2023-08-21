import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniland/screens/auth/signup_screen.dart';

import '../../widgets/buttons.dart';
import '../home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isObsecured = false;

  Future<void> _login(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      // If login is successful, navigate to the home screen.
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMessage("No user found for that email.", "Error");
      } else if (e.code == 'wrong-password') {
        showMessage("Wrong password provided for that user.", "Error");
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showMessage(String message, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void setObsecured() {
    setState(() {
      _isObsecured = !_isObsecured;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  "Welcome Mate!",
                  style: TextStyle(fontFamily: "Poppins-bold", fontSize: 23),
                ),
                const Text(
                  "Make it work, make it right, make it fast..",
                  style: TextStyle(fontFamily: "medium"),
                ),

                //form

                Form(
                    child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.person_outline_outlined),
                              labelText: "Email",
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)))),
                      const SizedBox(height: 15),
                      TextFormField(
                          obscureText: _isObsecured,
                          controller: passwordController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.fingerprint_rounded),
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
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forget password?",
                              ))),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.maxFinite,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                          ),
                          onPressed: _isLoading ? null : () => _login(context),
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text('Login'),
                        ),
                      ),
                      const SizedBox(height: 15),

                      const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "or",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(height: 15),
                      const MyButton(
                          image: "lib/images/search.png",
                          text: "Continue with Google",
                          color: Colors.white,
                          textColor: Colors.black),

                      //dont have account
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style:
                                TextStyle(fontFamily: "medium", fontSize: 13),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: const Text(
                              "Signup",
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
