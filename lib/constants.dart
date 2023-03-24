import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

Future<void> sendNotifiy(uid, text, orderNumber,isWating) async {
  try {
    String notifiyId = const Uuid().v1();

    FirebaseFirestore.instance.collection('glasses').doc(uid)
        .collection('notification')
        .doc(notifiyId)
        .set({'body': text, 'uid': uid,
         'orderNumber': orderNumber,
         'isWating':isWating,
         'datetime':DateTime.now()
         });
  } catch (e) {
     if (kDebugMode) {
       print(e.toString());
     }
  }
}
