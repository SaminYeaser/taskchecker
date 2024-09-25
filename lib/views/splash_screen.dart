
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:taskchecker/views/home.dart';

class SplashScreen extends StatelessWidget {

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: AnimatedSplashScreen(
              backgroundColor: Colors.white,
              duration: 3000,
              splashIconSize: 400,
              splash: Image.asset('assets/images/daylight_logo.png'),
              nextScreen: HomePage(),
              splashTransition: SplashTransition.slideTransition,

            ),
          ),
        )
    );
  }
}

