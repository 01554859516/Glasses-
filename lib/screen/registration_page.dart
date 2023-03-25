import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_button.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_textform.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/cashehelper.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/home_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/header_widget.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class RegistrationPage extends StatefulWidget {
  final bool? admin;
  final String myuid;
  const RegistrationPage({super.key, this.admin, required this.myuid});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  File? image;
  bool? isLoading;

  final _formKey = GlobalKey<FormState>();
  final fristNameController = TextEditingController();

  final lastNameController = TextEditingController();
  final birthdATEController = TextEditingController();

  Future<void> register() async {
    try {
      var ref = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('products/${Uri.file(image!.path).pathSegments.last}')
          .putFile(image!);
      var imageUrl = await ref.ref.getDownloadURL();
      CollectionReference users =
          FirebaseFirestore.instance.collection("glasses");

      users.doc(widget.myuid).set({
        "FristName": fristNameController.text,
        "LastName": lastNameController.text,
        "birthDate": birthdATEController.text,
        "image": imageUrl
      });
      setState(() {
        uid = widget.myuid;
        CacheHelper.savedata(key: 'uid', value: widget.myuid);

        if (widget.admin != null) {
          admin = 'admin';
          CacheHelper.savedata(key: 'admin', value: 'admin');
          navigtonandfinish(context, const AdiminHome());
        } else {
          navigtonandfinish(context, const HomeScreen());
        }
      });
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
    fristNameController.dispose();
    birthdATEController.dispose();
    lastNameController.dispose();

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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: const EdgeInsets.only(
                top: 170,
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: InkWell(
                            onTap: () async {
                              var pick = ImagePicker();
                              final pickimage = await pick.pickImage(
                                  source: ImageSource.gallery);
                              if (pickimage != null) {
                                setState(() {
                                  image = File(pickimage.path);
                                });
                              }
                            },
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: image != null
                                      ? FileImage(image!) as ImageProvider
                                      : const NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/512/812/812850.png?w=740&t=st=1679253272~exp=1679253872~hmac=773faf8983ded274b9c5c84fb661bb434cc41fc9c8163e08a25e4a3f671cd6da',
                                        ),
                                  radius: 72,
                                ),
                                const CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Color(0xff8A02AE),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        CustomFormTextfield(
                          controller: fristNameController,
                          type: TextInputType.name,
                          lableText: "FritName",
                          hintText: "Enter your FritName",
                          prefix: Icons.person,
                          obscure: false,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Empty value";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        CustomFormTextfield(
                          controller: lastNameController,
                          type: TextInputType.name,
                          lableText: "LastName",
                          hintText: "Enter your LastName",
                          prefix: Icons.person_2,
                          obscure: false,
                          suffixIcon: null,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Empty value";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        CustomFormTextfield(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Empty value";
                            }
                            return null;
                          },
                          controller: birthdATEController,
                          type: TextInputType.datetime,
                          lableText: "datetime",
                          hintText: "Enter your datetime",
                          prefix: Icons.schedule_sharp,
                          obscure: false,
                        ),
                        const SizedBox(height: 60),
                        Column(
                          children: [
                            if (isLoading == true)
                              const CircularProgressIndicator(
                                  color: Colors.purple),
                            if (isLoading != true)
                              CustomBotton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (image != null) {
                                      register().whenComplete(() =>
                                          navigtonandfinish(
                                              context, const HomeScreen()));
                                    } else {
                                      showSnakBar(context, 'No image selcated');
                                    }
                                  } else {
                                    showSnakBar(context, "Error...");
                                  }
                                },
                                text: 'Register',
                                width: 200.0,
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
