import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/cashehelper.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/them.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/editproduct.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/mange_products.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/pendingproducts.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/wating.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/login_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class AdiminHome extends StatelessWidget {
  const AdiminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: current,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Head(text: 'DashBoard'),
              MyButton(
                function: () {
                  navigtonto(
                      context,
                      const MangeProducts(
                        isEdit: false,
                        text: 'Add Products',
                      ));
                },
                text: 'Add Products',
              ),
              MyButton(
                function: () {
                  navigtonto(
                    context,
                    const PendingProducts(),
                  );
                },
                text: 'Pending Products',
              ),
              MyButton(
                function: () {
                  navigtonto(context, const Wating());
                },
                text: 'Wating Products',
              ),
              MyButton(
                function: () {
                  navigtonto(context, const EditProduct());
                },
                text: 'Edit Products',
              ),
              MyButton(
                function: () {
                  admin = '';
                  CacheHelper.removedatae(key: 'admin').whenComplete(
                      () => navigtonandfinish(context, const LoginScreen()));
                },
                text: 'Logout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Head extends StatelessWidget {
  final String text;
  const Head({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: Color(0xff8A02AE),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final Function function;

  const MyButton({super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
          onPressed: () {
            function();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8A02AE),
              minimumSize: const Size(300, 76),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          )),
    );
  }
}
