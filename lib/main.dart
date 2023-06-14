import 'package:attandance_marker/screens/att_page.dart';
import 'package:attandance_marker/screens/home/home_screen.dart';
import 'package:attandance_marker/screens/home/today.dart';
import 'package:attandance_marker/screens/mobile_screen.dart';
import 'package:attandance_marker/screens/web_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
            .copyWith(secondary: Colors.redAccent.shade200),
        // iconTheme: IconThemeData(color: Colors.redAccent.shade200),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      // home: AttPage(
      //   mobileScreen:MobileScreen(),
      //   webScreen:WebScreen()
      // ),
    );
  }
}