import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_button.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_textform.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/cashehelper.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/login_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/header_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isVisable = true;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();

  register() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credential.user != null) {
        setState(() {
          credential.user!.sendEmailVerification();
          uid = credential.user!.uid;
          CacheHelper.savedata(key: 'uid', value: credential.user!.uid);
        });
      }

      CollectionReference users =
          FirebaseFirestore.instance.collection("glasses");

      users
          .doc(credential.user!.uid)
          .set({
            "username": userNameController.text,
            "phone": phoneController.text,
            "email": emailController.text,
            "password": passwordController.text,
          })
          // ignore: avoid_print
          .then((value) => print("User Added"))
          // ignore: avoid_print
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnakBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnakBar(context, 'The account already exists for that email.');
      } else {
        showSnakBar(context, '"Error - please try again late');
      }
    } catch (err) {
      showSnakBar(context, err.toString());
    }
  }

  final double _headerHeight = 190;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(
                _headerHeight,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 200,
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomFormTextfield(
                          controller: userNameController,
                          type: TextInputType.name,
                          lableText: "UserName",
                          hintText: "Enter your UserName",
                          prefix: Icons.person,
                          obscure: false,
                        ),
                        const SizedBox(height: 20.0),
                        CustomFormTextfield(
                          controller: phoneController,
                          type: TextInputType.phone,
                          lableText: "Phone",
                          hintText: "Enter your Phone",
                          prefix: Icons.phone,
                          obscure: false,
                          suffixIcon: null,
                        ),
                        const SizedBox(height: 20.0),
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
                        const SizedBox(height: 20.0),
                        CustomFormTextfield(
                          validator: (value) {
                            return value!.length < 8
                                ? "Enter at lest 8 Characters"
                                : null;
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          lableText: "Password",
                          hintText: "Enter your Password",
                          prefix: Icons.lock,
                          obscure: isVisable ? true : false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: isVisable
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                        const SizedBox(height: 60),
                        CustomBotton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await register();
                              if (!mounted) return;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            } else {
                              showSnakBar(context, "Error...");
                            }
                          },
                          text: 'Register',
                          width: 200.0,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don\"t have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
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
