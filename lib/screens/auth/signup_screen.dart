import 'package:attendance_marker/constants.dart';
import 'package:attendance_marker/screens/auth/login_screen.dart';
import 'package:attendance_marker/widgets/input_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
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
                  "Sign up",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 40,
                ),
                InputText(hintText: "email", controller: _emailController),
                SizedBox(height: 20),
                InputText(
                    hintText: "username", controller: _usernameController),
                SizedBox(height: 20),
                InputText(
                    hintText: "password", controller: _passwordController),
                SizedBox(height: 20),
                ElevatedButton(onPressed: () {}, child: Text("Sign Up")),
                SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text("Already User? LOGIN"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
