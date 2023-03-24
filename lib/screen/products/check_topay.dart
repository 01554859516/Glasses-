import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/appbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/cashehelper.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/notification.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constants.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/mange_products.dart';
import 'package:uuid/uuid.dart';

class CheckToPay extends StatefulWidget {
  final double totalPrice;
  final List cartId;
  const CheckToPay({super.key, required this.totalPrice, required this.cartId});

  @override
  State<CheckToPay> createState() => _CheckToPayState();
}

class _CheckToPayState extends State<CheckToPay> {
  final TextEditingController controllerLens = TextEditingController();
  final TextEditingController controllerOptical = TextEditingController();
  final TextEditingController controllerAdress1 = TextEditingController();
  final TextEditingController controllerAdress2 = TextEditingController();
  final TextEditingController controllerCode = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int number = 1;
  final ScrollController scrollController = ScrollController();

  Future<void> gettoken() async {
    try {
      FirebaseMessaging massaging = FirebaseMessaging.instance;
      await massaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      );
      var value = await massaging.getToken();
      setState(() {
        token = value;
        CacheHelper.savedata(key: 'token', value: value);
        localnotifications();
      });
    } on FirebaseMessaging catch (er) {
      setState(() {
        er.onTokenRefresh;
      });
    }
  }

  bool? isLoading;

  Future<void> confirmOrder() async {
    setState(() {
      isLoading = true;
    });
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    int orderNumber = Random().nextInt(90000) + 10000;
    String watingId = const Uuid().v1();

    try {
      await FirebaseFirestore.instance.collection('Watting').doc(watingId).set({
        'Adress1': controllerAdress1.text.trim(),
        'Adress2': controllerAdress2.text.trim(),
        'Code': controllerCode.text.trim(),
        'LensesType': controllerLens.text.trim(),
        'Optical': controllerOptical.text.trim(),
        'totalprice': '${widget.totalPrice * number} \$ ',
        'uid': uid,
        'token': token,
        'orderNumber': orderNumber,
        'watingId': watingId,
        'datetime': DateTime.now()
      });
      sendNotifiy(
          uid,
          'The order has been sent to the merchant to be reviewed. Please wait until the request is reviewed within a maximum period of 24 hours Your order number is',
          orderNumber,
          true
          );

      deletCat();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnakBar(context, e.toString());
    }
  }

  void deletCat() {
    try {
      for (int i = 0; i < widget.cartId.length; i++) {
        FirebaseFirestore.instance
            .collection('cart')
            .doc(widget.cartId[i])
            .delete();
      }
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Color(0xff8A02AE),
            statusBarIconBrightness: Brightness.light),
        backgroundColor: const Color(0xff8A02AE),
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //       (Color(0xffDC54FE)),
        //       Color(0xff8A02AE),
        //     ]
        //     ),
        //   ),
        // ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          ProductAndPrice(),
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        controller: scrollController,
        itemBuilder: (context, index) => Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            if (isLoading == true)
              const LinearProgressIndicator(
                backgroundColor: Color(0xff8A02AE),
                color: Color(0xffDC54FE),
              ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                // height: AppSizes.getHight(context, 80),
                color: Colors.red.withOpacity(0.1),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'You can transfer money through the following number ',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      TextSpan(
                        text: '01008569855',
                        style: TextStyle(color: Colors.red, fontSize: 19),
                      ),
                      TextSpan(
                        text: ' and please keep the payment code',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ItemField(
                controller: controllerLens,
                fristText: 'Lenses type ',
                hintText: 'Lenses',
                textInputType: TextInputType.text,
                validator: (lenses) {
                  if (lenses!.isEmpty) {
                    return 'Lenses is Empty';
                  }
                  return null;
                }),
            ItemField(
                controller: controllerOptical,
                fristText: 'lens pressure ',
                hintText: 'pressure',
                textInputType: TextInputType.text,
                validator: (lenses) {
                  if (lenses!.isEmpty) {
                    return 'pressure is Empty';
                  }
                  return null;
                }),
            ItemField(
                controller: controllerAdress1,
                fristText: 'AdressLine 1',
                hintText: 'Adress',
                textInputType: TextInputType.text,
                validator: (lenses) {
                  if (lenses!.isEmpty) {
                    return 'Adress is Empty';
                  }
                  return null;
                }),
            ItemField(
                controller: controllerAdress2,
                fristText: 'AdressLine 2',
                hintText: 'Adress',
                textInputType: TextInputType.text,
                validator: (lenses) {
                  if (lenses!.isEmpty) {
                    return 'Adress is Empty';
                  }
                  return null;
                }),
            ItemField(
                controller: controllerCode,
                fristText: 'Code',
                hintText: 'Last 2 numers from phone payment',
                textInputType: TextInputType.text,
                validator: (lenses) {
                  if (lenses!.length != 2) {
                    return 'Code is inviald';
                  }
                  return null;
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Quantity *',
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (number != 1) {
                            setState(() {
                              number--;
                            });
                          }
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.purple.shade500,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          '$number',
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            number++;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.purple.shade500,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TotalPrice *',
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.totalPrice * number} \$ ',
                    style: const TextStyle(
                        fontSize: 19,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            MyButton(
                text: 'Confirm Order',
                function: () {
                  if (formKey.currentState!.validate()) {
                    gettoken().whenComplete(() => confirmOrder().whenComplete(() => Navigator.of(context).pop()));
                  }
                })
          ]),
        ),
      ),
    );
  }
}
