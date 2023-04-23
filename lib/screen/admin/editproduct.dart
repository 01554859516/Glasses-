import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/them.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/mange_products.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: current,
        child: SafeArea(
            child: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
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
                              text: 'Edit Products',
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var snap = snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                                  return Item(snap: snap);
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
                            'No Product to Edit',
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

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.snap,
  });

  final Map<String, dynamic> snap;
  Future<void> delet(context, productId) async {
    try {
      FirebaseFirestore.instance.collection('products').doc(productId).delete();
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
            MangeProducts(
              isEdit: true,
              image: snap['productsImage'],
              productsCatgeroy: snap['productCatgeroy'],
              productsDescription: snap['productDescription'],
              productsName: snap['productName'],
              productsPrice: snap['productPrice'],
              productsid: snap['productId'],
              text: 'Edit ${snap['productName']}',
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.23,
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
                    // fit: BoxFit.cover,
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
                        InkWell(
                          onTap: () {
                            delet(context, snap['productId']).whenComplete(() =>
                                showSnakBar(
                                    context, 'Product Delated successfully'));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(
                              Icons.delete,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: Color(0xff8A02AE),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
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
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:suuuuuuuuuuuuuuuuuuu/constant/them.dart';
// import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
// import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/mange_products.dart';
// import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

// class EditProduct extends StatelessWidget {
//   const EditProduct({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//     AnnotatedRegion(
//         value: current,
//         child: SafeArea(
//             child: Scaffold(
//           body: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('products')
//                   .orderBy(
//                     'datetime',
//                     descending: true,
//                   )
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: Color(0xff8A02AE),
//                     ),
//                   );
//                 } else {
//                   return snapshot.data!.docs.isNotEmpty
//                       ? Column(
//                           children: [
//                             const Head(
//                               text: 'Edit Products',
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.8,
//                               child: ListView.separated(
//                                 itemBuilder: (context, index) {
//                                   var snap = snapshot.data!.docs[index].data()
//                                       as Map<String, dynamic>;
//                                   return Item(snap: snap);
//                                 },
//                                 separatorBuilder: (context, index) => Container(
//                                   width: double.infinity,
//                                   color: Colors.grey.shade400,
//                                   height: 1,
//                                 ),
//                                 itemCount: snapshot.data!.docs.length,
//                               ),
//                             ),
//                           ],
//                         )
//                       : Center(
//                           child: Text(
//                             'No Product to Edit',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headlineMedium!
//                                 .copyWith(color: Colors.purple),
//                           ),
//                         );
//                 }
//               }),
//         )));
//   }
// }

// class Item extends StatelessWidget {
//   const Item({
//     super.key,
//     required this.snap,
//   });

//   final Map<String, dynamic> snap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         navigtonto(
//             context,
//             MangeProducts(
//               isEdit: true,
//               image: snap['productsImage'],
//               productsCatgeroy: snap['productCatgeroy'],
//               productsDescription: snap['productDescription'],
//               productsName: snap['productName'],
//               productsPrice: snap['productPrice'],
//               productsid: snap['productId'],
//               text: 'Edit ${snap['productName']}',
//             ));
//       },
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         height: MediaQuery.of(context).size.height * 0.2,
//         child: Row(
//           children: [
//             Stack(
//               alignment: AlignmentDirectional.bottomStart,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image(
//                     image: NetworkImage('${snap['productsImage']}'),
//                     width: MediaQuery.of(context).size.width * 0.36,
//                     height: MediaQuery.of(context).size.height * 0.35,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     snap['productName'],
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       height: 1,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 2,
//                   ),
//                   Text(snap['productDescription'],
//                       maxLines: 6,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.bodySmall),
//                   const Spacer(),
//                   Expanded(
//                     child: Row(
//                       children: [
//                         Text(
//                           snap['productPrice'],
//                           style: const TextStyle(
//                             fontSize: 15,
//                             color: Colors.purple,
//                           ),
//                         ),
//                         const Spacer(),
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 5),
//                           child: CircleAvatar(
//                             radius: 13,
//                             backgroundColor: Color(0xff8A02AE),
//                             child: Icon(
//                               Icons.edit,
//                               color: Colors.white,
//                               size: 15,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
