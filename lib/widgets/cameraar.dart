import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/size_manger.dart';
import 'package:uuid/uuid.dart';

class CameraAr extends StatefulWidget {
  final String image;
  final Map<String, dynamic> snap2;
  const CameraAr({super.key, required this.image, required this.snap2});

  @override
  State<StatefulWidget> createState() => CameraArs();
}

class CameraArs extends State<CameraAr> {
  late List<CameraDescription> cameras;
  late CameraController controller;
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

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(
      cameras[1],
      ResolutionPreset.medium,
    );
    await controller.initialize();
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
        body: FutureBuilder<void>(
          future: initializeCamera(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  SizedBox(
                      height: AppSizes.height(context),
                      child: CameraPreview(controller)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60, left: 25),
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Image.network(
                        widget.image,
                        height: AppSizes.getHight(context, 250),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: FloatingActionButton(
                          backgroundColor: Colors.purple,
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            addToCart(
                              context,
                              widget.snap2['productsImage'],
                              widget.snap2['productName'],
                              widget.snap2['productPrice'],
                              widget.snap2['productDescription'],
                              widget.snap2['productCatgeroy'],
                            ).whenComplete(() {
                              Navigator.of(context).pop();
                              showSnakBar(context, 'Item Aded');
                            });
                          }),
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
