import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_button.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_textform.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/cashehelper.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/size_manger.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/provider/google_singin.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admincheck.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/forgotpassword_page.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/forgotpasswordverification.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/home_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/registration_page.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/header_widget.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class LoginScreen extends StatefulWidget {
  final bool? admin;
  const LoginScreen({super.key, this.admin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisable = false;

  Future<bool> singIn() async {
    bool isLogin = false;
    try {
      User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim()))
          .user;
      if (user != null) {
        setState(() {
          uid = user.uid;
          CacheHelper.savedata(key: 'uid', value: user.uid);
          isLogin = true;
        });
      }
      return isLogin;
    } on FirebaseAuthException catch (e) {
      showSnakBar(context, "Error : ${e.code}");
      return isLogin;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final double _headerHeight = 190;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

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
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                        CustomFormTextfield(
                          controller: emailController,
                          validator: (email) {
                            return email!.isNotEmpty
                                ? null
                                : "Enter a valid Email";
                          },
                          type: TextInputType.emailAddress,
                          lableText: "Email",
                          hintText: "Enter your Email",
                          prefix: Icons.email,
                          obscure: false,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomFormTextfield(
                          validator: (value) {
                            return value!.length < 4
                                ? "Enter at lest 8 Characters"
                                : null;
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          lableText: "Password",
                          hintText: "Enter your Password",
                          prefix: Icons.lock,
                          obscure: isVisable ? false : true,
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
                        const SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage()),
                              );
                            },
                            child: const Text(
                              "forgot your password?",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        CustomBotton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              {
                                singIn().then((value) {
                                  if (value) {
                                    if (FirebaseAuth.instance.currentUser!
                                            .emailVerified ==
                                        false) {
                                      navigtonandfinish(
                                          context, const VerifyEmailpage());
                                    } else {
                                      if (widget.admin != null) {
                                        setState(() {
                                          admin = 'admin';
                                          CacheHelper.savedata(
                                              key: 'admin', value: 'admin');
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdiminHome()));
                                      } else {
                                        navigtonandfinish(
                                            context, const HomeScreen());
                                      }
                                    }
                                  }
                                });
                              }
                            }
                          },
                          text: 'Login',
                          width: 200.0,
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
                                          const RegistrationPage()),
                                );
                              },
                              child: Text(
                                "Create",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
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
