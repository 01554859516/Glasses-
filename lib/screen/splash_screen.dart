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
    //  Scaffold(
    //   body: Container(
    //     decoration: new BoxDecoration(
    //       gradient: new LinearGradient(
    //         colors: [
    //           Theme.of(context).accentColor,
    //           Theme.of(context).primaryColor
    //         ],
    //         begin: FractionalOffset(0, 0),
    //         end: FractionalOffset(1.0, 0.0),
    //         stops: [0.0, 1.0],
    //         tileMode: TileMode.clamp,
    //       ),
    //     ),

    //     // child: AnimatedOpacity(
    //     //   opacity: _isVisible ? 1.0 : 0,
    //     //   duration: Duration(milliseconds: 1200),
    //     //   child: Center(
    //     //     child: Container(
    //     //       height: 140.0,
    //     //       width: 140.0,
    //     //       child: Center(
    //     //         child: ClipOval(
    //     //           child: Image(
    //     //             height: 300,
    //     //             width: 200,
    //     //             image: AssetImage("images/Icons.png"),
    //     //           ),
    //     //         ),
    //     //       ),
    //     //       // decoration: BoxDecoration(
    //     //       //     // shape: BoxShape.circle,
    //     //       //     // color: Colors.white,
    //     //       //     boxShadow: [
    //     //       //       BoxShadow(
    //     //       //         color: Colors.black.withOpacity(0.3),
    //     //       //         blurRadius: 2.0,
    //     //       //         offset: Offset(5.0, 3.0),
    //     //       //         spreadRadius: 2.0,
    //     //       //       ),
    //     //       //     ]),
    //     //     ),
    //     //   ),
    //     // ),
    //   ),
    // );
    // Scaffold(
    //   backgroundColor: kMainColor,
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SizedBox(
    //           height: 100,
    //         ),
    //         CircleAvatar(
    //             radius: 68,
    //             backgroundColor: Colors.white,
    //             child: Image(
    //               image: AssetImage("images/icons/splash.png"),
    //             )),
    //         SizedBox(
    //           height: 50,
    //         ),
    //         CircularProgressIndicator(
    //           backgroundColor: Colors.pink[300],
    //         ),
    //         Container(
    //           padding: EdgeInsets.only(top: 20, bottom: 50),
    //           child: Text(
    //             'Glasses_Store',
    //             style: TextStyle(
    //               color: Colors.amber,
    //               fontSize: 30,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
