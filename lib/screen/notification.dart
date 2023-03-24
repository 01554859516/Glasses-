import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';

class NotificationHome extends StatelessWidget {
  const NotificationHome({super.key});
  Future<void> deletNotification() async {
    try {
      CollectionReference collectionRef = FirebaseFirestore.instance
          .collection('glasses')
          .doc(uid)
          .collection('notification');
      QuerySnapshot querySnapshot = await collectionRef.get();
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: Color(0xff8A02AE),
                statusBarIconBrightness: Brightness.light),
            backgroundColor: const Color(0xff8A02AE),
            actions: [
              IconButton(
                  onPressed: () {
                    deletNotification()
                        .whenComplete(() => Navigator.of(context).pop());
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ))
            ],
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
              "Notification",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('glasses')
                  .doc(uid)
                  .collection('notification')
                  .orderBy('datetime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.purple,
                  ));
                } else {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var snap = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                          return NotificationItem(
                            snap2: snap,
                          );
                        },
                        separatorBuilder: (context, index) => Container(
                              height: 1,
                              color: Colors.grey.shade600,
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                            ),
                        itemCount: snapshot.data!.docs.length);
                  } else {
                    return const Center(
                      child: Icon(
                        Icons.notifications,
                        size: 120,
                        color: Colors.purple,
                      ),
                    );
                  }
                }
              })),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Map<String, dynamic> snap2;
  const NotificationItem({super.key, required this.snap2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(40), topLeft: Radius.circular(40))),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: snap2['body'],
              style: const TextStyle(color: Colors.black, fontSize: 17),
            ),
            TextSpan(
              text: ' ${snap2['orderNumber']}',
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
            const TextSpan(
              text: '  to follow up',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
