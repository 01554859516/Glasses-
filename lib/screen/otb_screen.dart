import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_button.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/cashehelper.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/size_manger.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/home_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/registration_page.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/header_widget.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class OtbScreen extends StatefulWidget {
  final String verificationId;
  final bool? admin;
  const OtbScreen({super.key, required this.verificationId, this.admin});

  @override
  State<OtbScreen> createState() => _OtbScreen();
}

class _OtbScreen extends State<OtbScreen> {
  String? otb;
  bool? isLoading;

  Future<void> verification() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: otb!);
      User? user = (await firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
          
            uid = user.uid;
        
        
        DocumentSnapshot snapshot =
            await firebaseFirestore.collection('glasses').doc(user.uid).get();
        if (snapshot.exists) {
          setState(() {
            uid = user.uid;
            CacheHelper.savedata(key: 'uid', value: user.uid);
           
            if (widget.admin != null) {
              admin = 'admin';
              CacheHelper.savedata(key: 'admin', value: 'admin');
              navigtonandfinish(context, const AdiminHome());
            } else {
              navigtonandfinish(context, const HomeScreen());
            }
          });
        } else {
          // ignore: use_build_context_synchronously
          navigtonandfinish(
              context,
              RegistrationPage(
                admin: widget.admin,
                myuid: user.uid,
              ));
        }
      }

      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnakBar(context, "Error : ${e.code}");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final double _headerHeight = 190;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(
                _headerHeight,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  const Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Enter the OTP Send to your phone number",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppSizes.getHight(context, 15)),
                          child: Pinput(
                            length: 6,
                            closeKeyboardWhenCompleted: true,
                            showCursor: true,
                            defaultPinTheme: PinTheme(
                                textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)
                                    .copyWith(color: Colors.purple),
                                width: AppSizes.getWidth(context, 60),
                                height: AppSizes.getHight(context, 55),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.purple))),
                            onCompleted: (value) {
                              setState(() {
                                otb = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              if (isLoading == true)
                                const CircularProgressIndicator(
                                    color: Colors.purple),
                              if (isLoading != true)
                                CustomBotton(
                                  onPressed: () {
                                    verification();
                                  },
                                  text: 'Verifiy',
                                  width: 200.0,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
