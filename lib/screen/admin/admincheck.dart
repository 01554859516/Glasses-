import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/mange_products.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/login_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class AdminCheck extends StatefulWidget {
  const AdminCheck({
    super.key,
  });

  @override
  State<AdminCheck> createState() => _AdminCheck();
}

class _AdminCheck extends State<AdminCheck> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Head(text: 'Admin'),
            ItemField(
                controller: controller,
                fristText: 'Password',
                hintText: 'Write your Admin Paswword',
                textInputType: TextInputType.visiblePassword,
                validator: (e) {
                  if (e.toString() != 'admin') {
                    return 'Inccroect Password';
                  }
                  return null;
                }),
            MyButton(
                text: 'Check',
                function: () {
                  if (formKey.currentState!.validate()) {
                    navigtonto(
                        context,
                        const LoginScreen(
                          admin: true,
                        ));
                  }
                })
          ],
        ),
      ),
    ));
  }
}
