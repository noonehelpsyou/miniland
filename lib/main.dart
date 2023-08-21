import 'package:flutter/material.dart';
import 'package:miniland/screens/HomePage/Dues.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miniland/screens/acedmic_detail/acedmic_detail.dart';
import 'package:miniland/screens/acedmic_detail/teacherProfile.dart';
import 'package:miniland/screens/bus_screen/bus_screen.dart';
import 'package:miniland/screens/home.dart';
import 'package:miniland/screens/online_course/cousre.dart';
import 'package:miniland/screens/splash.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'firebase_options.dart';

void main() async {
  NepaliUtils(Language.nepali);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
