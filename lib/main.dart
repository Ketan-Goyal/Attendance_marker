import 'package:attendance_marker/models/user_model.dart';
import 'package:attendance_marker/screens/att_page.dart';
import 'package:attendance_marker/screens/home/home_screen.dart';
import 'package:attendance_marker/screens/mobile_screen.dart';
import 'package:attendance_marker/screens/web_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDFXJPs1Wzwm8nJt4pmIA0xI4oIK61N-js",
      projectId: "attandance-app-1adf8",
      messagingSenderId: "134561835321",
      appId: "1:134561835321:web:335a9ad50e9349e3cb60e8",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Attendance app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.grey, brightness: Brightness.dark)
            .copyWith(secondary: Colors.grey.shade500),
        // iconTheme: IconThemeData(color: Colors.redAccent.shade200),
        useMaterial3: true,
      ),
      // home: LocationScreen(),
      home: AuthCheck(),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (sharedPreferences.getString('employeeId') != null) {
        setState(() {
          UserModel.uid = sharedPreferences.getString('employeeId')!;
          userAvailable = true;
        });
      }
    } catch (e) {
      setState(() {
        userAvailable = false;
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return userAvailable
        ? const HomeScreen()
        : const AttPage(mobileScreen: MobileScreen(), webScreen: WebScreen());
  }
}
