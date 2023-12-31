import 'package:attendance_marker/constants.dart';
import 'package:attendance_marker/widgets/input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late SharedPreferences sharedPreference;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: isWeb ? width / 3.5 : width / 1.2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                InputText(
                    hintText: "Employee ID", controller: usernameController),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Login"),
                  ),
                  onTap: () async {
                    UserModel.uid = usernameController.text.trim();

                    String password = passwordController.text.trim();

                    if (UserModel.uid.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please Enter Valid Details"),
                        ),
                      );
                    } else {
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("users")
                          .where('ID', isEqualTo: UserModel.uid)
                          .get();
                      try {
                        if (password == snap.docs[0]['Password'] &&
                            snap.docs[0]['logged'] == false) {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(snap.docs[0].id)
                              .update({
                            'logged': true,
                          });
                          sharedPreference =
                              await SharedPreferences.getInstance();

                          sharedPreference
                              .setString('employeeId', UserModel.uid)
                              .then((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Wrong Password!! or you are "
                                  "logged in already"),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    }

                    // print(snap.docs.length);
                    // try {
                    //   print(snap.docs[0]['Password']);
                    // } catch (e) {
                    //   print("cought exception");
                    // }
                  },
                ),
                const SizedBox(height: 30),
                Text('v1.0.0')

                // const SizedBox(height: 20),
                // TextButton(
                //     onPressed: () {
                //       Navigator.of(context).pushReplacement(MaterialPageRoute(
                //           builder: (context) => SignupScreen()));
                //     },
                //     child: Text("New User? SIGN UP"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
