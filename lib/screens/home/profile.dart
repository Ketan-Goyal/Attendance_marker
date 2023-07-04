import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 4,
            width: width,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(width / 10),
            ),
            alignment: Alignment.center,
            width: width / 5,
            height: width / 5,
            child: Icon(
              Icons.person,
              size: width / 10,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            child: Text(
              "${UserModel.name}",
              style: TextStyle(
                fontSize: width / 15,
              ),
            ),
          ),
          Divider(
            indent: width / 8,
            endIndent: width / 8,
            color: Colors.grey.shade800,
          ),
          Container(
            alignment: Alignment.center,
            height: height / 10,
            child: Text(
              "Email - ${UserModel.email}",
              style: TextStyle(
                fontSize: height / 30,
                color: Colors.white70,
              ),
            ),
          ),
          Divider(
            indent: width / 8,
            endIndent: width / 8,
            color: Colors.grey.shade800,
          ),
          Container(
            alignment: Alignment.center,
            height: height / 10,
            child: Text(
              "ID - ${UserModel.uid}",
              style: TextStyle(
                fontSize: height / 30,
                color: Colors.white70,
              ),
            ),
          ),
          Divider(
            indent: width / 8,
            endIndent: width / 8,
            color: Colors.grey.shade800,
          ),
          Container(
            alignment: Alignment.center,
            height: height / 10,
            child: Text('v1.0.0'),
          ),
        ],
      ),
    );
  }
}
