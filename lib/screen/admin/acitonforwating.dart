import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constants.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/mange_products.dart';
import 'package:http/http.dart' as http;

class AcitonForWating extends StatefulWidget {
  final String head;
  final Map<String, dynamic> snap;
  final bool isConfirm;
  const AcitonForWating(
      {super.key,
      required this.head,
      required this.snap,
      required this.isConfirm});

  @override
  State<AcitonForWating> createState() => _AcitonForWatingState();
}

class _AcitonForWatingState extends State<AcitonForWating> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool? isLoading;

  Future<void> sendConfirm() async {
    setState(() {
      isLoading = true;
    });

    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Authorization':
                'key=AAAAEVuLssw:APA91bGQc4hchq3NEEP0ZcIFM2e6iNw0P597FYi7A1yO9bOzQUACG7SlRvUs5Fh5VJywy4y8Y893DBjpKdrpHMVQ8gopyiMPo1KGIprN5qGWaPTFl3Ceb7U1k95u998rlU7p_r4Kguow',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': controller.text,
              'title': 'Glasess',
            },
            "notification": <String, dynamic>{
              "title": 'Glasess',
              "body": controller.text,
              "android_channel_id": "2"
            },
            "to": widget.snap['token']
          }));
      sendNotifiy(widget.snap['uid'], controller.text.trim(),
          widget.snap['orderNumber'], false);

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

  Future<void> deletOrder() async {
    try {
      setState(() {
        isLoading = true;
      });
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Authorization':
                'key=AAAAEVuLssw:APA91bGQc4hchq3NEEP0ZcIFM2e6iNw0P597FYi7A1yO9bOzQUACG7SlRvUs5Fh5VJywy4y8Y893DBjpKdrpHMVQ8gopyiMPo1KGIprN5qGWaPTFl3Ceb7U1k95u998rlU7p_r4Kguow',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': controller.text,
              'title': 'Glasess',
            },
            "notification": <String, dynamic>{
              "title": 'Glasess',
              "body": controller.text,
              "android_channel_id": "2"
            },
            "to": widget.snap['token']
          }));
      sendNotifiy(widget.snap['uid'], controller.text.trim(),
          widget.snap['orderNumber'], false);
      FirebaseFirestore.instance
          .collection('Watting')
          .doc(widget.snap['watingId'])
          .delete();
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Head(text: widget.head),
            if (isLoading == true)
              const LinearProgressIndicator(
                backgroundColor: Color(0xff8A02AE),
                color: Color(0xffDC54FE),
              ),
            ItemField(
                controller: controller,
                fristText: 'Messge',
                hintText: 'Write aMessge for castowmer',
                textInputType: TextInputType.text,
                validator: (e) {
                  if (e!.isEmpty) {
                    return 'Invild value';
                  }
                  return null;
                }),
            MyButton(
                text: 'Send',
                function: () {
                  if (formKey.currentState!.validate()) {
                    if (widget.isConfirm == true) {
                      sendConfirm().whenComplete(() {
                        FirebaseFirestore.instance
                            .collection('Watting')
                            .doc(widget.snap['watingId'])
                            .delete();
                        Navigator.of(context).pop();
                      });
                    } else {
                      deletOrder()
                          .whenComplete(() => Navigator.of(context).pop());
                    }
                  }
                })
          ],
        ),
      ),
    ));
  }
}
