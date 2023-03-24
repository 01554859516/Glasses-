import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_button.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_textform.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/login_screen.dart';

import '../widgets/header_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final double _headerHeight = 250;

  resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      if (!mounted) return;
      showSnakBar(context, "Done - please check ur email.");
    } on FirebaseAuthException catch (e) {
      showSnakBar(context, "Error : ${e.code}");
    }

    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: _headerHeight,
                  child: HeaderWidget(
                    _headerHeight,
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 60),
                    width: 100,
                    child: const Image(
                      color: Colors.white,
                      image: AssetImage("images/lock.png"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SafeArea(
              child: Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Forgot ',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      const Text(
                        'password? ',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Enter the email address associated with your account.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "We will email you a verification code to check your authenticity.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      CustomFormTextfield(
                        validator: (email) {
                          return email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z]+"))
                              ? null
                              : "Enter a valid Email";
                        },
                        controller: emailController,
                        type: TextInputType.text,
                        lableText: "Email",
                        hintText: "Enter your Email",
                        prefix: Icons.email,
                        obscure: false,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Center(
                        child: CustomBotton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              resetPassword();
                            } else {
                              showSnakBar(context, "Error...");
                            }
                          },
                          width: 200.0,
                          text: "SEND",
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Remembre your password?",
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
