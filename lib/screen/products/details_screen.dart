import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/appbar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/common/custom_button.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/deep_ar_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/cameraar.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> snap;
  final String image;
  final String price;
  final String dis;
  final String name;

  const DetailsScreen(
      {super.key,
      required this.image,
      required this.dis,
      required this.price,
      required this.name,
      required this.snap});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final DeepArController _controller = DeepArController();

  // @override
  // void initState() {
  //   _controller.initialize(
  //       androidLicenseKey:
  //           "d75977a7089c235fc8b5803b4063e9899f3548c39d8b4feaf32ca17fef7066583b3f3d2cc876bca0",
  //       iosLicenseKey: "---iOS key---",
  //       resolution: Resolution.high);
  //   // setState(() {});
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(240, 252, 252, 252),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Color(0xff8A02AE),
            statusBarIconBrightness: Brightness.light),
        title: const Text(
          "Details screen",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        child: CustomBotton(
          text: 'deep ar',
          width: double.infinity,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeepArScreen(),
                ));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Column(
              children: [
                Image.network(widget.image),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        '${widget.price} \$',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.star,
                            size: 23,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                          Icon(
                            Icons.star,
                            size: 23,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                          Icon(
                            Icons.star,
                            size: 23,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                          Icon(
                            Icons.star,
                            size: 23,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                          Icon(
                            Icons.star,
                            size: 23,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: const [
                          Icon(
                            Icons.edit_location,
                            size: 26,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "glass shop",
                            style: TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    "Details:${widget.dis} ",
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton.icon(
                  onPressed: () {
                    navigtonto(
                        context,
                        CameraAr(
                          image: widget.image,
                          snap2: widget.snap,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Test Withe Camera filter',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
