import 'package:attendance_marker/constants.dart';
import 'package:flutter/material.dart';

class AttPage extends StatefulWidget {
  final Widget mobileScreen;
  final Widget webScreen;
  const AttPage(
      {super.key, required this.mobileScreen, required this.webScreen});

  @override
  State<AttPage> createState() => _AttPageState();
}

class _AttPageState extends State<AttPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 700) {
        isWeb = false;
        return widget.mobileScreen;
      } else {
        isWeb = true;
        return widget.webScreen;
      }
    });
  }
}
