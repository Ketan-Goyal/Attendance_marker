import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';


class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});
  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height/8,
                decoration: BoxDecoration(
                    color: Colors.redAccent.shade200,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))

                ),
                child: Container(
                  margin: EdgeInsets.only(top:6,left:10),
                  child: Text(" Welcome User",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      )),
                  alignment:Alignment.centerLeft ,
                ),

              ),
              Container(
                margin: EdgeInsets.only(left:width/18,top:10),
                child: Text(" Today's Status",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                    )),
                alignment:Alignment.centerLeft ,
              ),

              Container(
                margin: EdgeInsets.only(top:10,left: width/14,right:width/14),
                height: height/4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2,2),

                  ),]
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Check In",style: TextStyle(fontSize: 20,color: Colors.black38),),
                          Text("9:30",style: TextStyle(fontSize: 30,fontFamily: 'TrojanPro_Bold.ttf'),),
                      ],
                      ),
                    ),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Check Out:",style: TextStyle(fontSize: 20,color: Colors.black38),),
                        Text("17:30",style: TextStyle(fontSize: 30,fontFamily: 'TrojanPro_Bold.ttf'),),
                      ],
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10),
                child: Text("20:00:00",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: width/12,
                    )),
                alignment:Alignment.center ,
              ),
              Container(
                alignment:Alignment.center,
                child: Text("14-Jun-2023",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: width/18,
                    )),

              ),
              Container(
                margin: EdgeInsets.only(top:80,left:20,right:20),
                child: Builder(builder: (context){
                  final GlobalKey<SlideActionState> key=GlobalKey();
                  return SlideAction(
                    innerColor: Colors.red,
                    outerColor: Colors.white,
                    text: "Slide to Check out",
                    textStyle: TextStyle(color: Colors.black54,fontSize: 25),

                  );
                }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
