import 'package:attandance_marker/constants.dart';
import 'package:attandance_marker/widgets/input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: isWeb ? width / 3.5 : width / 1.2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 25),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String id = usernameController.text.trim();

                    String password = passwordController.text.trim();

                    if (id.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please Enter Valid Details"),
                        ),
                      );
                    } else {
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("users")
                          .where('ID', isEqualTo: id)
                          .get();
                      try {
                        if (password == snap.docs[0]['Password']) {
                          sharedPreference =
                              await SharedPreferences.getInstance();
                          sharedPreference
                              .setString('employeeId', id)
                              .then((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Wrong Password!!!"),
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
                  child: const Text("Login"),
                ),
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
