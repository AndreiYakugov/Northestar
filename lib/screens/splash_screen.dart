import 'dart:async';
import 'package:flutter/material.dart';
import 'package:northstar_app/screens/home_screen.dart';
import 'package:northstar_app/screens/sign_in_screen.dart';

import '../utils/SharedPrefUtils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String username = "";

  @override
  void initState() {
    super.initState();
    _init();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => username == "" ? const LoginScreen() : const HomeScreen(),
                transitionDuration: Duration(seconds: 1),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              ),
            )
    );
  }

  Future<void> _init() async {
    var un = await SharedPrefUtils.readPrefStr("usrname");
    setState(() {
      if(un != null) username = un;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    const Image(
                      image: AssetImage('assets/logo.png'),
                      width: 350,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}