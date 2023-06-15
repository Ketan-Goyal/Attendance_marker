import 'package:attandance_marker/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .where('ID', isEqualTo: UserModel.uid)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("users")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd-MMM-yyyy').format(DateTime.now()))
          .get();

      setState(() {
        Checkin = snap2['checkin'];
        Checkout = snap2['checkout'];
      });
    } catch (e) {
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
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height / 8,
                decoration: BoxDecoration(
                    color: Colors.redAccent.shade200,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Container(
                  margin: EdgeInsets.only(top: 6, left: 10),
                  child: Text(
                    " Welcome " + UserModel.uid,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: width / 18, top: 10),
                child: Text(" Today's Status",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                    )),
                alignment: Alignment.centerLeft,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 10, left: width / 14, right: width / 14),
                height: height / 4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
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
                            "Check In",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black38),
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
                          "Check Out:",
                          style: TextStyle(fontSize: 20, color: Colors.black38),
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
                      child:
                          Text(DateFormat('hh:mm:ss a').format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: width / 12,
                              )),
                      alignment: Alignment.center,
                    );
                  }),
              Container(
                alignment: Alignment.center,
                child: Text(DateFormat('dd-MMMM-yyyy').format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: width / 18,
                    )),
              ),
              Checkout == "--/--"
                  ? Container(
                      margin: EdgeInsets.only(
                          top: 80, left: 20, right: 20, bottom: 10),
                      child: Builder(builder: (context) {
                        final GlobalKey<SlideActionState> key = GlobalKey();
                        return SlideAction(
                          innerColor: Colors.red,
                          outerColor: Colors.white,
                          text: Checkin == "--/--"
                              ? "Slide to Check In"
                              : "Slide to Check Out",
                          textStyle:
                              TextStyle(color: Colors.black54, fontSize: 25),
                          key: key,
                          onSubmit: () async {
                            key.currentState!.reset();
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
                                'checkout':
                                    DateFormat('hh:mm').format(DateTime.now())
                              });
                              setState(() {
                                Checkout =
                                    DateFormat('hh:mm').format(DateTime.now());
                              });
                            } catch (e) {
                              setState(() {
                                Checkin =
                                    DateFormat('hh:mm').format(DateTime.now());
                              });
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(snap.docs[0].id)
                                  .collection("Record")
                                  .doc(DateFormat('dd-MMM-yyyy')
                                      .format(DateTime.now()))
                                  .set({
                                'checkin':
                                    DateFormat('hh:mm').format(DateTime.now())
                              });
                            }
                          },
                        );
                      }),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                          top: 80, left: width / 10, right: width / 10),
                      child: Center(
                        child: Text(
                          "YOU HAVE ALREADY CHECKED OUT\nTHANKS!",
                          style: TextStyle(
                            fontSize: width / 20,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
