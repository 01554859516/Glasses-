import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/appbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/cashehelper.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/home_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/login_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/products/checkout.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/products/details_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/profile_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';
import 'package:uuid/uuid.dart';

class GlassesMen extends StatelessWidget {
  final Map<String, dynamic> snap;
  final String catName;
  const GlassesMen({super.key, required this.snap, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Amr.png"),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(snap['image']),
                
              ),
              accountEmail: Text(
                "${FirebaseAuth.instance.currentUser?.phoneNumber}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              accountName: Text(
                "${snap['FristName']}$snap['LastName']",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              title: const Text("Home"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("My products"),
              leading: const Icon(Icons.add_shopping_cart),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckOut(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("About"),
              leading: const Icon(Icons.help_center),
              onTap: () {},
            ),
            ListTile(
              title: const Text("profile page"),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.exit_to_app),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                CacheHelper.removedatae(key: 'uid').whenComplete(
                    () => navigtonandfinish(context, const LoginScreen()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Color(0xff8A02AE),
            statusBarIconBrightness: Brightness.light),
        title: const Text("Glasses Store"),
        actions: const [
          NotificationAppBar(),
          ProductAndPrice(),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              (Color(0xffDC54FE)),
              Color(0xff8A02AE),
            ]),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('productCatgeroy', isEqualTo: catName)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.purple,
              ));
            } else {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: GridView.count(
                    //shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),

                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1 / 1.72,
                    crossAxisCount: 2,
                    children:
                        List.generate(snapshot.data!.docs.length, (index) {
                      var snap2 = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      return Griditem(
                        snap2: snap2,
                      );
                    }),
                  ));
            }
          }),
    );
  }
}

class Griditem extends StatelessWidget {
  final Map<String, dynamic> snap2;

  const Griditem({super.key, required this.snap2});
  Future<void> addToCart(context, imageUrl, productsName, productsPrice,
      productsDescription, productsCatgeroy) async {
    String productId = const Uuid().v1();
    try {
      await FirebaseFirestore.instance.collection('cart').doc(productId).set({
        'productsImage': imageUrl,
        'productName': productsName,
        'productPrice': productsPrice,
        'productDescription': productsDescription,
        'productCatgeroy': productsCatgeroy,
        'productId': productId,
        'datetime': DateTime.now(),
        'uid': uid
      });
      showSnakBar(context, 'Product Aded successfully');
    } on FirebaseException catch (e) {
      showSnakBar(context, e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigtonto(
            context,
            DetailsScreen(
              image: '${snap2['productsImage']}',
              dis: "${snap2['productDescription']}",
              price: "${snap2['productPrice']}",
              name: "${snap2['productName']}",
              snap: snap2,
            ));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  width: double.infinity,
                  image: NetworkImage('${snap2['productsImage']}'),
                  height: 200,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${snap2['productName']}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        "${snap2['productPrice']}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.purple,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          addToCart(
                            context,
                            snap2['productsImage'],
                            snap2['productName'],
                            snap2['productPrice'],
                            snap2['productDescription'],
                            snap2['productCatgeroy'],
                          );
                        },
                        icon: const CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.purple,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 15,
                            color: Colors.white,
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
    );
  }
}
