import 'dart:async';

import 'package:attandance_marker/models/user_model.dart';
import 'package:attandance_marker/services/location_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});
  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  String Checkin = "--/--";
  String Checkout = "--/--";
  String CheckinT = "";
  String CheckoutT = "";

  double OLongitude = 0;
  double OLatitude = 0;

  LocationServices LocServ = LocationServices();

  @override
  void initState() {
    super.initState();
    _userDetails();
    _getRecord();
  }

  void _userDetails() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where('ID', isEqualTo: UserModel.uid)
        .get();
    UserModel.name = snap.docs[0]['username'];
    UserModel.email = snap.docs[0]['email'];

    OLatitude = snap.docs[0]['Latitude'];
    print(OLongitude);
    OLongitude = snap.docs[0]['Longitude'];
  }

  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .where('ID', isEqualTo: UserModel.uid)
          .get();

      //take the user's office location

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("users")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd-MMM-yyyy').format(DateTime.now()))
          .get();

      setState(() {
        Checkin = snap2['checkin'];
        Checkout = snap2['checkout'];
        CheckinT = snap2['checkinT'];
        CheckoutT = snap2['checkoutT'];
      });
    } catch (e) {
      print(e);
      setState(() {
        Checkin = "--/--";
        Checkout = "--/--";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 8,
              decoration: BoxDecoration(
                  // color: Colors.redAccent.shade200,
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Container(
                margin: EdgeInsets.only(top: 6, left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  " Welcome " + UserModel.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: width / 18, top: 10),
              alignment: Alignment.centerLeft,
              child: const Text(" Today's Status",
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 10, left: width / 14, right: width / 14),
              height: height / 4,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white24,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Clock In",
                          style: TextStyle(fontSize: 20, color: Colors.white54),
                        ),
                        Text(
                          Checkin,
                          style: TextStyle(
                              fontSize: 30, fontFamily: 'TrojanPro_Bold.ttf'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Clock Out:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        Checkout,
                        style: TextStyle(
                            fontSize: 30, fontFamily: 'TrojanPro_Bold.ttf'),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            StreamBuilder(
                stream: Stream.periodic(
                  const Duration(seconds: 1),
                ),
                builder: (context, snapshot) {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(DateFormat('hh:mm:ss a').format(DateTime.now()),
                        style: TextStyle(
                            fontSize: width / 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.center,
                  );
                }),
            Container(
              alignment: Alignment.center,
              child: Text(DateFormat('dd-MMMM-yyyy').format(DateTime.now()),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width / 18,
                  )),
            ),
            Checkout == "--/--"
                ? Container(
                    margin: EdgeInsets.only(
                        top: 80, left: 20, right: 20, bottom: 10),
                    child: Builder(builder: (context) {
                      final GlobalKey<SlideActionState> key = GlobalKey();
                      return TextButton(
                        style: ButtonStyle(fixedSize:
                            MaterialStateProperty.resolveWith((states) {
                          return Size.fromRadius(60);
                        }), backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          // If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white60;
                          }
                          return Theme.of(context).primaryColor;
                        })),
                        child: Checkin == "--/--"
                            ? Text(
                                "Clock In",
                                style: TextStyle(fontSize: 20),
                              )
                            : Text(
                                "Clock Out",
                                style: TextStyle(fontSize: 20),
                              ),
                        onPressed: () async {
                          await LocServ.getCurrentLocation();
                          UserModel.latitude = LocServ.latitude;
                          UserModel.longitude = LocServ.longitude;
                          if (UserModel.longitude != 181) {
                            final Office = Location(OLatitude, OLongitude);
                            final CurrentPos = Location(
                                UserModel.latitude, UserModel.longitude);
                            print("${Office.longitude} ${Office.latitude}");
                            print(
                                "${CurrentPos.longitude} ${CurrentPos.latitude}");
                            final haversineDistance = HaversineDistance();
                            final Distance = haversineDistance
                                .haversine(Office, CurrentPos, Unit.METER)
                                .floor();
                            print(Distance);
                            if (Distance <= 100) {
                              QuerySnapshot snap = await FirebaseFirestore
                                  .instance
                                  .collection("users")
                                  .where('ID', isEqualTo: UserModel.uid)
                                  .get();

                              DocumentSnapshot snap2 = await FirebaseFirestore
                                  .instance
                                  .collection("users")
                                  .doc(snap.docs[0].id)
                                  .collection("Record")
                                  .doc(DateFormat('dd-MMM-yyyy')
                                      .format(DateTime.now()))
                                  .get();

                              try {
                                String CheckIN = snap2['checkin'];
                                print(snap2['checkin']);

                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(snap.docs[0].id)
                                    .collection("Record")
                                    .doc(DateFormat('dd-MMM-yyyy')
                                        .format(DateTime.now()))
                                    .set({
                                  'checkin': CheckIN,
                                  'checkinT': CheckinT,
                                  'checkout': DateFormat('hh:mm a')
                                      .format(DateTime.now()),
                                  'checkoutT': DateFormat('yyyy-MM-dd hh:mm:ss')
                                      .format(DateTime.now())
                                });
                                setState(() {
                                  Checkout = DateFormat('hh:mm a')
                                      .format(DateTime.now());
                                  CheckoutT = DateFormat('yyyy-MM-dd hh:mm:ss')
                                      .format(DateTime.now());
                                });
                              } catch (e) {
                                setState(() {
                                  Checkin = DateFormat('hh:mm a')
                                      .format(DateTime.now());
                                  CheckinT = DateFormat('yyyy-MM-dd hh:mm:ss')
                                      .format(DateTime.now());
                                });
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(snap.docs[0].id)
                                    .collection("Record")
                                    .doc(DateFormat('dd-MMM-yyyy')
                                        .format(DateTime.now()))
                                    .set({
                                  'checkin': DateFormat('hh:mm a')
                                      .format(DateTime.now()),
                                  'checkout': "--/--",
                                  'checkinT': DateFormat('yyyy-MM-dd hh:mm:ss')
                                      .format(DateTime.now()),
                                  'checkoutT': "--/--",
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("You are out of office Location"),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("You Have Denied Location "
                                    "Permissions"),
                              ),
                            );
                          }
                        },
                      );
                    }),
                  )
                : Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: height / 10),
                    child: Center(
                      child: Text(
                        "You have Checked Out for the Day\nYou have Spent "
                        "${DateTime.parse(CheckoutT).difference(DateTime.parse(CheckinT)).inMinutes} mins today",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
