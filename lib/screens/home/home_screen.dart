import 'package:attendance_marker/screens/home/profile.dart';
import 'package:attendance_marker/screens/home/today.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<IconData> navigationIcons = [
    Icons.checklist,
    Icons.person,
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: const [
            TodayScreen(),
            Profile_page(),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          height: height / 12,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white54,
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
                      child: SizedBox(
                        height: height,
                        width: width,
                        child: Center(
                          child: Icon(
                            navigationIcons[i],
                            color: i == currentIndex
                                ? Colors.white
                                : Colors.white38,
                            size: i == currentIndex ? 35 : 24,
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
