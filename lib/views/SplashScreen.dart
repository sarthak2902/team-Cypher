import 'package:community_safety/views/AddNewAdmin.dart';
import 'package:community_safety/views/AdminLogin.dart';
import 'package:community_safety/views/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Expanded(
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(209, 46, 46, 1),
                Color.fromARGB(255, 251, 167, 168)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              const Text(
                'AlertMe',
                style: TextStyle(
                  fontSize: 50,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(
                      255, 255, 255, 255), // Set text color to black
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "An Emergency Hotline App",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 120,
              ),
              Image.asset('assets/images/logo_round.png',
                  width: 200, height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
