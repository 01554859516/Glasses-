import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/notification.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/products/checkout.dart';

class ProductAndPrice extends StatelessWidget {
  const ProductAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .where('uid', isEqualTo: uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          } else {
            return Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 219, 16, 206),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${snapshot.data!.docs.length}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckOut(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      color: const Color.fromARGB(179, 246, 245, 245),
                    ),
                  ],
                ),
              ],
            );
          }
        });
  }
}

// ignore: must_be_immutable
class NotificationAppBar extends StatelessWidget {
  const NotificationAppBar({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('glasses')
            .doc(uid)
            .collection('notification')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          } else {
            
            return Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 219, 16, 206),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${snapshot.data!.docs.length}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationHome(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.notifications),
                      color: const Color.fromARGB(179, 246, 245, 245),
                    ),
                  ],
                ),
              ],
            );
          }
        });
  }
}
