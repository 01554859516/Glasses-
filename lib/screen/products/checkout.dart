import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/appbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_button.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/pendingproducts.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/products/check_topay.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Color(0xff8A02AE),
            statusBarIconBrightness: Brightness.light),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              (Color(0xffDC54FE)),
              Color(0xff8A02AE),
            ]),
          ),
        ),
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
          "Checkout",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          ProductAndPrice(),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('cart')
              .where('uid', isEqualTo: uid)
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
                  ? Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var snap = snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                                  return ListItem(
                                    snap: snap,
                                    isCheckout: true,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CustomBotton(
                            text: "pay All",
                            width: 150,
                            onPressed: () {
                              double totalProductPrice =
                                  0.0; // Declare a variable to store the sum
                              List<String> cartIds = [];

                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                var snap = snapshot.data!.docs[i].data()
                                    as Map<String, dynamic>;
                                cartIds.add(snap['productId']);
                                double productPrice = double.parse(snap[
                                    'productPrice']); // Get the productPrice value
                                totalProductPrice +=
                                    productPrice; // Add it to the total
                              }
                              navigtonto(
                                  context,
                                  CheckToPay(
                                    totalPrice: totalProductPrice,
                                    cartId: cartIds,
                                  ));
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        'No Product',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.purple),
                      ),
                    );
            }
          }),
    );
  }
}
