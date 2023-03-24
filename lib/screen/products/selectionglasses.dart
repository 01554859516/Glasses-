import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/size_manger.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/products/glassesmen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class SelecationGlasses extends StatelessWidget {
  final Map<String, dynamic> snap;
  const SelecationGlasses({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xff8A02AE),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: Text(
                    'glasses',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                CategoryItem(
                  image: "images/men.jpg",
                  text: "Men's glasses",
                  widget: GlassesMen(snap: snap, catName: 'Men'),
                ),
                CategoryItem(
                  image: "images/women.jpg",
                  text: "Women's glasses",
                  widget: GlassesMen(snap: snap, catName: 'Woman'),
                ),
                CategoryItem(
                  image: "images/children.jpg",
                  text: "Children's glasses",
                  widget: GlassesMen(snap: snap, catName: 'Children'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String image;
  final String text;
  final Widget widget;
  const CategoryItem(
      {super.key,
      required this.image,
      required this.text,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigtonto(context, widget);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.matrix([
                0.5,
                0,
                0,
                0,
                0,
                0,
                0.5,
                0,
                0,
                0,
                0,
                0,
                0.5,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ]),
              child: Image.asset(
                image,
                height: AppSizes.getHight(context, 220),
                width: AppSizes.getWidth(context, 400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
