import 'dart:async';

import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/login_screen.dart';

class SplashSceen extends StatefulWidget {
  const SplashSceen({super.key});

  @override
  State<SplashSceen> createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 3000),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen())),
    );
    Timer(const Duration(milliseconds: 10), (() {
      setState(() {
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const FractionalOffset(0, 0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).primaryColor
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: const [
            Image(
              color: Colors.white70,
              height: 210,
              width: 210,
              image: AssetImage(
                "images/logo.png",
              ),
            ),
            Positioned(
              bottom: 260,
              child: Text(
                "Glasses Store",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
    
  }
}
