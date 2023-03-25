import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_button.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/size_manger.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/provider/google_singin.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admincheck.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/otb_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/header_widget.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/textfromfiled.dart';

class LoginScreen extends StatefulWidget {
  final bool? admin;
  const LoginScreen({super.key, this.admin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  bool? isLoading;

  Future<void> singIn() async {
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      final String phonenumber = phoneController.text.trim();

      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+${country.phoneCode}$phonenumber",
        verificationCompleted: (phoneAuthCredential) async {
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          navigtonto(
            context,
            OtbScreen(verificationId: verificationId, admin: widget.admin),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
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
    phoneController.dispose();

    super.dispose();
  }

  final double _headerHeight = 190;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Country country = Country(
      phoneCode: '20',
      countryCode: 'EG',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Egypt',
      example: 'Egypt',
      displayName: 'Egypt',
      displayNameNoCountryCode: 'EG',
      e164Key: '');

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
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
                    "Hello",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Signin into Your account ",
                    style: TextStyle(
                      color: Colors.grey,
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
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: MyTextFromField(
                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            color: Colors.purple.withOpacity(0.1),
                            hinttext: 'Enter phone number',
                            onChange: (value) {
                              if (phoneController.text.length < 12) {
                                setState(() {});
                              }
                            },
                            perfixicon: Container(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      countryListTheme: CountryListThemeData(
                                          bottomSheetHeight:
                                              AppSizes.height(context) * 0.6),
                                      onSelect: (value) {
                                        setState(() {
                                          country = value;
                                        });
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Text(
                                        '${country.flagEmoji} + ${country.phoneCode}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  )),
                            ),
                            suifxicon: phoneController.text.length > 10
                                ? const CircleAvatar(
                                    backgroundColor: Colors.purple,
                                    radius: 15,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  )
                                : null,
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
                                  onPressed: () async {
                                    if (_globalKey.currentState!.validate()) {
                                      {
                                        if (phoneController.text.trim().length >
                                            10) {
                                          await singIn();
                                        }
                                      }
                                    }
                                  },
                                  text: 'Login',
                                  width: 200.0,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 90),
                          child: SizedBox(
                            width: 299,
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    thickness: 0.6,
                                    color: Color.fromARGB(255, 205, 7, 255),
                                  ),
                                ),
                                Text(
                                  "oR",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 205, 7, 255),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.6,
                                    color: Color.fromARGB(255, 205, 7, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  googleSignInProvider.googlelogin();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.purple, width: 1),
                                  ),
                                  child: Image.asset(
                                    "images/google-logo.png",
                                    height: 29,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 25,
                              left: AppSizes.getWidth(context, 220)),
                          child: InkWell(
                            onTap: () {
                              navigtonto(context, const AdminCheck());
                            },
                            child: const Text(
                              'Admin',
                              style: TextStyle(color: Colors.purple),
                            ),
                          ),
                        )
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
