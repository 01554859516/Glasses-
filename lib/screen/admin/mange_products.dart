import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/snakbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/them.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class MangeProducts extends StatefulWidget {
  final String text;
  final String? productsName;
  final String? image;
  final bool? isEdit;

  final String? productsPrice;
  final String? productsid;
  final String? productsDescription;
  final String? productsCatgeroy;

  const MangeProducts(
      {super.key,
      required this.text,
      this.productsCatgeroy,
      this.productsDescription,
      this.productsName,
      this.productsPrice,
      this.image,
      required this.isEdit,
      this.productsid});

  @override
  State<MangeProducts> createState() => _MangeProductsState();
}

class _MangeProductsState extends State<MangeProducts> {
  final TextEditingController productsNameController = TextEditingController();

  final TextEditingController productsPriceController = TextEditingController();
  final TextEditingController productsDescriptionController =
      TextEditingController();

  final TextEditingController productsCatgeroyController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  File? image;
  bool? isLoading;

  Future<void> addProducts() async {
    String productId = const Uuid().v1();
    setState(() {
      isLoading = true;
    });
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    try {
      if (image != null) {
        var ref = await firebase_storage.FirebaseStorage.instance
            .ref()
            .child('products/${Uri.file(image!.path).pathSegments.last}')
            .putFile(image!);
        var imageUrl = await ref.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('Pendingproducts')
            .doc(productId)
            .set({
          'productsImage': imageUrl,
          'productName': productsNameController.text.trim(),
          'productPrice': productsPriceController.text.trim(),
          'productDescription': productsDescriptionController.text.trim(),
          'productCatgeroy': productsCatgeroyController.text.trim(),
          'productId': productId,
          'datetime': DateTime.now()
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnakBar(context, e.toString());
    }
  }

  Future<void> editProducts() async {
    setState(() {
      isLoading = true;
    });
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    try {
      String? imageEdit;
      if (image != null) {
        var ref = await firebase_storage.FirebaseStorage.instance
            .ref()
            .child('products/${Uri.file(image!.path).pathSegments.last}')
            .putFile(image!);
        var imageUrl = await ref.ref.getDownloadURL();
        setState(() {
          imageEdit = imageUrl;
        });
      }
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productsid)
          .update({
        if (imageEdit != '' && imageEdit != null) 'productsImage': imageEdit,
        if (productsNameController.text != '')
          'productName': productsNameController.text.trim(),
        if (productsPriceController.text != '')
          'productPrice': productsPriceController.text.trim(),
        if (productsDescriptionController.text != '')
          'productDescription': productsDescriptionController.text.trim(),
        if (productsCatgeroyController.text != '')
          'productCatgeroy': productsCatgeroyController.text.trim(),
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnakBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    productsCatgeroyController.dispose();
    productsDescriptionController.dispose();
    productsNameController.dispose();
    productsPriceController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit == true) {
      productsNameController.text = widget.productsName!;
      productsCatgeroyController.text = widget.productsCatgeroy!;
      productsDescriptionController.text = widget.productsDescription!;
      productsPriceController.text = widget.productsPrice!;
    }
    

    return AnnotatedRegion(
      value: current,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Scaffold(
              body: ListView.builder(
            itemCount: 1,
            controller: scrollController,
            itemBuilder: (context, index) => Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Head(text: widget.text),
                  if (isLoading == true)
                    const LinearProgressIndicator(
                      backgroundColor: Color(0xff8A02AE),
                      color: Color(0xffDC54FE),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            var pick = ImagePicker();
                            final pickimage = await pick.pickImage(
                                source: ImageSource.gallery);
                            if (pickimage != null) {
                              setState(() {
                                image = File(pickimage.path);
                              });
                            } else {}
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: image != null
                                    ? FileImage(image!) as ImageProvider
                                    : NetworkImage(
                                        widget.image != null &&
                                                widget.image != ''
                                            ? "${widget.image}"
                                            : 'https://cdn-icons-png.flaticon.com/512/812/812850.png?w=740&t=st=1679253272~exp=1679253872~hmac=773faf8983ded274b9c5c84fb661bb434cc41fc9c8163e08a25e4a3f671cd6da',
                                      ),
                                radius: 72,
                              ),
                              const CircleAvatar(
                                radius: 17,
                                backgroundColor: Color(0xff8A02AE),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ItemField(
                    controller: productsNameController,
                    fristText: 'Products Name',
                    hintText: 'Name',
                    textInputType: TextInputType.name,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Name is Empty';
                      }
                      return null;
                    },
                  ),
                  ItemField(
                    controller: productsPriceController,
                    fristText: 'Products Price',
                    hintText: 'Price',
                    textInputType: TextInputType.number,
                    validator: (price) {
                      if (price!.isEmpty) {
                        return 'price is Empty';
                      }
                      return null;
                    },
                  ),
                  ItemField(
                    controller: productsDescriptionController,
                    fristText: 'Products Description',
                    hintText: 'Description',
                    textInputType: TextInputType.text,
                    validator: (des) {
                      if (des!.length < 200) {
                        return 'At least 200 Charchter';
                      }
                      return null;
                    },
                  ),
                  ItemField(
                    controller: productsCatgeroyController,
                    fristText: 'Products Catgeroy',
                    hintText:  'Children, Men, Woman',
                    textInputType: TextInputType.text,
                    validator: (cat) {
                      if (cat != 'Children' && cat != 'Men' && cat != 'Woman') {
                        return 'No Catgeroy found';
                      }
                      return null;
                    },
                  ),
                  MyButton(
                      text: widget.isEdit == true
                          ? 'Edit Products'
                          : 'Add Products',
                      function: () {
                        if (widget.isEdit == true) {
                          editProducts().whenComplete(() {
                            setState(() {
                              image = null;
                            });
                            Navigator.of(context).pop();
                            return showSnakBar(
                                context, 'Products Edit Sucsfully');
                          });
                        } else {
                          if (formKey.currentState!.validate()) {
                            if (image != null) {
                              addProducts().whenComplete(() {
                                setState(() {
                                  image = null;
                                });
                                Navigator.of(context).pop();
                                return showSnakBar(
                                    context, 'Products Add Sucsfully');
                              });
                            } else {
                              showSnakBar(context, 'no Image selected');
                            }
                          }
                        }
                      })
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class ItemField extends StatelessWidget {
  const ItemField(
      {super.key,
      required this.controller,
      required this.fristText,
      required this.hintText,
      required this.textInputType,
      required this.validator});

  final TextEditingController controller;
  final String fristText;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fristText,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.grey.shade700),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: controller,
              keyboardType: textInputType,
              autofocus: false,
              textDirection: TextDirection.ltr,
              maxLines: 15,
              minLines: 1,
              validator: validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.purple.withOpacity(0.2),
                hintText: hintText,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(style: BorderStyle.none)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(style: BorderStyle.none)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(style: BorderStyle.none)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(style: BorderStyle.none)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
