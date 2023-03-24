import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_button.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/home_screen.dart';

class VerifyEmailpage extends StatefulWidget {
  const VerifyEmailpage({super.key});

  @override
  State<VerifyEmailpage> createState() => _VerifyEmailpageState();
}

class _VerifyEmailpageState extends State<VerifyEmailpage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        // when we click on the link that existed on yahoo
        await FirebaseAuth.instance.currentUser!.reload();

        // is email verified or not (clicked on the link or not) (true or false)
        setState(() {
          isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        });

        if (isEmailVerified) {
          timer.cancel();
        }
      });
    }
  }

  sendVerificationEmail() async {
    try {
      // await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      showSnakBar(context, "ERROR => ${e.toString()}");
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

   double headerHeight = 300;

  // bool _pinSuccess = false;

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomeScreen()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "A verification email has been sent to your email",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomBotton(
                    onPressed: () {
                      canResendEmail ? sendVerificationEmail() : null;
                    },
                    text: "Resent Email",
                    width: 400,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  CustomBotton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    text: "cancel",
                    width: 400,
                  ),
                ],
              ),
            ),
          );

    // Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     leading: IconButton(
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //       icon: Icon(
    //         Icons.arrow_back_ios_rounded,
    //         color: Colors.white,
    //       ),
    //     ),
    //     elevation: 0,
    //   ),
    //   backgroundColor: Colors.white,
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         // Container(
    //         //   height: _headerHeight,
    //         //   child: HeaderWidget(_headerHeight, true),
    //         // ),
    //         // SizedBox(
    //         //   height: 40,
    //         // ),
    //         // Text(
    //         //   "Phone Verification",
    //         //   style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
    //         // ),
    //         // SizedBox(
    //         //   height: 10,
    //         // ),
    //         // Text(
    //         //   "We need to register your phone without getting started!",
    //         //   style: TextStyle(
    //         //     fontSize: 16,
    //         //   ),
    //         //   textAlign: TextAlign.center,
    //         // ),
    //         // SizedBox(
    //         //   height: 30,
    //         // ),
    //         // Pinput(
    //         //   length: 6,
    //         //   // defaultPinTheme: defaultPinTheme,
    //         //   // focusedPinTheme: focusedPinTheme,
    //         //   // submittedPinTheme: submittedPinTheme,
    //         //   showCursor: true,
    //         //   onCompleted: (pin) => print(pin),
    //         // ),
    //         // SizedBox(
    //         //   height: 20,
    //         // ),
    //         CustomBotton(
    //           onPressed: () {},
    //           text: 'Verify Phone Number',
    //           width: 230.0,
    //         ),
    //         Row(
    //           children: [
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.pushNamedAndRemoveUntil(
    //                     context,
    //                     'phone',
    //                     (route) => false,
    //                   );
    //                 },
    //                 child: Text(
    //                   "Edit Phone Number ?",
    //                   style: TextStyle(color: Colors.black),
    //                 ))
    //           ],
    //         )
    //         // SafeArea(
    //         //   child: Container(
    //         //     alignment: Alignment.topLeft,
    //         //     margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
    //         //     child: Column(
    //         //       mainAxisAlignment: MainAxisAlignment.start,
    //         //       crossAxisAlignment: CrossAxisAlignment.start,
    //         //       children: [
    //         //         Text(
    //         //           'Verification',
    //         //           style: TextStyle(
    //         //               fontSize: 35,
    //         //               fontWeight: FontWeight.bold,
    //         //               color: Colors.black54),
    //         //         ),
    //         //         SizedBox(
    //         //           height: 10,
    //         //         ),
    //         //         Text(
    //         //           'Enter the verification code we just sent you on your email address.',
    //         //           style: TextStyle(
    //         //             fontWeight: FontWeight.bold,
    //         //             color: Colors.black54,
    //         //           ),
    //         //         ),
    //         //       ],
    //         //     ),
    //         //   ),
    //         // ),
    //         // SizedBox(height: 40.0),
    //         // Form(
    //         //   key: _formKey,
    //         //   child: Column(
    //         //     children: [
    //         //       OTPTextField(
    //         //         length: 4,
    //         //         width: 300,
    //         //         fieldWidth: 50,
    //         //         style: TextStyle(fontSize: 30),
    //         //         textFieldAlignment: MainAxisAlignment.spaceAround,
    //         //         fieldStyle: FieldStyle.underline,
    //         //         onCompleted: (pin) {
    //         //           setState(() {
    //         //             _pinSuccess = true;
    //         //           });
    //         //         },
    //         //       ),
    //         //       SizedBox(height: 50.0),
    //         //       Text.rich(
    //         //         TextSpan(
    //         //           children: [
    //         //             TextSpan(
    //         //               text: "If you didn't receive a code! ",
    //         //               style: TextStyle(
    //         //                 color: Colors.black38,
    //         //               ),
    //         //             ),
    //         //           ],
    //         //         ),
    //         //       ),
    //         //     ],
    //         //   ),
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
