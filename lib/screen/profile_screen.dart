import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/date_from_firestore.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/cashehelper.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/login_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              CacheHelper.removedatae(key: 'uid').whenComplete(
                  () => navigtonandfinish(context, const LoginScreen()));
            },
            label: const Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 135, 24, 176),
        leading: 
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Profile ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(31, 203, 7, 200),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Text(
                    "User Information",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Email :  ${credential?.email}",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "create date:${DateFormat("MMM d ,y").format(credential!.metadata.creationTime!)}",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "last Signed in:  ${DateFormat("MMM d ,y").format(credential!.metadata.lastSignInTime!)}",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('glasses');
                      credential?.delete();
                      users.doc(credential?.uid).delete();
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Delet user",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(31, 203, 7, 200),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Text(
                    "Edit User Information",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              GetDataFromFirestore(
                documentId: uid!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
