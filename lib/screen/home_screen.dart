import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/them.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/products/checkout.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/products/selectionglasses.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/support.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: current,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xff8A02AE),
            currentIndex: index,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.help,
                    color: Colors.white,
                  ),
                  label: 'Suppport'),
            ],
            onTap: (ind) {
              setState(() {
                index = ind;
              });
            },
          ),
          body: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('glasses')
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child:  CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  );
                } else {
                  var snap = snapshot.data!.data() as Map<String, dynamic>;
                  return IndexedStack(
                    index: index,
                    children:  [
                      SelecationGlasses(snap: snap),
          const CheckOut(),
          const Support(),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
