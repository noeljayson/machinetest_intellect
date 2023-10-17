import 'dart:async';

import 'package:flutter/material.dart';
import 'package:machinetest_intellect/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigatePage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Flutter App',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void navigatePage() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String user = sharedpref.getString("user").toString();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const RegisterScreen())));


    Timer(
        const Duration(seconds: 3),
            () => {
          if(user.isEmpty||user == "null"){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterScreen()))
          }
          else{
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>  HomeScreen()))
          }

        });
  }
}
