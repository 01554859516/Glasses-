import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/them.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';

class PendingProducts extends StatelessWidget {
  const PendingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: current,
        child: SafeArea(
            child: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Pendingproducts')
                  .orderBy(
                    'datetime',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff8A02AE),
                    ),
                  );
                } else {
                  return snapshot.data!.docs.isNotEmpty
                      ? Column(
                          children: [
                            const Head(
                              text: 'PendingEdit ',
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var snap = snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                                  return ListItem(
                                    snap: snap,
                                    isCheckout: false,
                                  );
                                },
                                separatorBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  color: Colors.grey.shade400,
                                  height: 1,
                                ),
                                itemCount: snapshot.data!.docs.length,
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            'No pending Product',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.purple),
                          ),
                        );
                }
              }),
        )));
  }
}

// ignore: must_be_immutable
class ListItem extends StatelessWidget {
  final bool isCheckout;
  const ListItem({super.key, required this.snap, required this.isCheckout});

  final Map<String, dynamic> snap;

  Future<void> confirmProducts(context, productId, imageUrl, productsName,
      productsPrice, productsDescription, productsCatgeroy) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .set({
        'productsImage': imageUrl,
        'productName': productsName,
        'productPrice': productsPrice,
        'productDescription': productsDescription,
        'productCatgeroy': productsCatgeroy,
        'productId': productId,
        'datetime': DateTime.now()
      });
      showSnakBar(context, 'Product Aded successfully');
    } on FirebaseException catch (e) {
      showSnakBar(context, e.message.toString());
    }
  }

  Future<void> delet(context, productId) async {
    try {
      if (isCheckout == false) {
        FirebaseFirestore.instance
            .collection('Pendingproducts')
            .doc(productId)
            .delete();
      } else {
        FirebaseFirestore.instance.collection('cart').doc(productId).delete();
      }
    } on FirebaseException catch (e) {
      showSnakBar(context, e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage('${snap['productsImage']}'),
                  width: MediaQuery.of(context).size.width * 0.36,
                  height: MediaQuery.of(context).size.height * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snap['productName'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(snap['productDescription'],
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall),
                const Spacer(),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        snap['productPrice'],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.purple,
                        ),
                      ),
                      const Spacer(),
                      if (isCheckout == false)
                        InkWell(
                          onTap: () {
                            confirmProducts(
                              context,
                              snap['productId'],
                              snap['productsImage'],
                              snap['productName'],
                              snap['productPrice'],
                              snap['productDescription'],
                              snap['productCatgeroy'],
                            ).whenComplete(
                                () => delet(context, snap['productId']));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Confirm',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.purple),
                            ),
                          ),
                        ),
                      if (isCheckout == true)
                        InkWell(
                          onTap: () {
                            delet(context, snap['productId']).whenComplete(() =>
                                showSnakBar(
                                    context, 'Product Delated successfully'));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(
                              Icons.delete,
                              color: Colors.purple,
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
    );
  }
}
