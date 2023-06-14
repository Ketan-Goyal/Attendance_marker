import 'package:attandance_marker/constants.dart';
import 'package:attandance_marker/screens/auth/signup_screen.dart';
import 'package:attandance_marker/widgets/input_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(

        child: SizedBox(
          width: isWeb?width/3.5:width/1.2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Login",style: TextStyle(fontSize: 25),),
                const SizedBox(height: 40,),
                InputText(hintText: "Employee ID",controller: _usernameController),
                const SizedBox(height: 20),
                InputText(hintText: "password",controller: _passwordController),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: (){}, child: const Text("Login")),
                const SizedBox(height: 20),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignupScreen()));
                }, child: Text("New User? SIGN UP"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
