import 'dart:async';

import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/products/checkout.dart';

class WhenDone extends StatefulWidget {
  const WhenDone({super.key});

  @override
  State<WhenDone> createState() => _WhenDone();
}

class _WhenDone extends State<WhenDone> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 3000),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const CheckOut())),
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
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              child: Icon(
                Icons.done,
                size: 120,
                color: Colors.purple,
              ),
            ),
            Positioned(
              bottom: 260,
              child: Text(
                "Orader Is Comelete",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
