import 'package:attandance_marker/screens/home/Calender.dart';
import 'package:attandance_marker/screens/home/profile.dart';
import 'package:attandance_marker/screens/home/today.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

  List<IconData> navigationIcons = [
    Icons.calendar_today,
    Icons.checklist,
    Icons.person,
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: currentIndex,
          children: [
            Calender_screen(),
            TodayScreen(),
            Profile_page(),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          height: height / 12,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = i;
                        });
                      },
                      child: Container(
                        height: height,
                        width: width,
                        color: Colors.white,
                        child: Center(
                          child: Icon(
                            navigationIcons[i],
                            color: i == currentIndex
                                ? Colors.redAccent.shade200
                                : Colors.black54,
                            size: i == currentIndex ? 32 : 24,
                          ),
                        ),
                      ),
                    ),
                  )
                }
              ],
            ),
          ),
        ));
  }
}
