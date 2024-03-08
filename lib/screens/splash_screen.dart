import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maxtech/screens/Main_Page.dart';
import 'package:maxtech/screens/login_page_screen.dart';
import 'package:maxtech/utils/colors.dart';
import 'package:maxtech/widget/textStyle.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      checking();
    });

    super.initState();
  }

  Future<void> checking() async {
    final pref = await SharedPreferences.getInstance();
    bool? loginCheck = pref.getBool('login');

    if (loginCheck == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    }
  }

  int numberOfMessages = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(), // Empty container to push the content upwards
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      color: lightGrey,
                      fontWeight: FontWeight.w500,
                      size: 14,
                      text: 'Welcome to',
                      fontfamily: 'inter',
                    ),
                    TextComponent(
                      color: kdarkText,
                      fontWeight: FontWeight.w700,
                      size: 30,
                      text: 'MaxTach™',
                      fontfamily: 'inter',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child:
                  Container(), // Empty container to push the content downwards
            ),
          ],
        ),
      ),
    );
  }

//get chat data
}
