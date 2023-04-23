import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';

class DeepArScreen extends StatefulWidget {
  const DeepArScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DeepArScreen> createState() => _DeepArScreenState();
}

class _DeepArScreenState extends State<DeepArScreen> {
  final DeepArController deepArController = DeepArController();

  @override
  void initState() {
    try {
      deepArController
          .initialize(
              androidLicenseKey:
                  "d75977a7089c235fc8b5803b4063e9899f3548c39d8b4feaf32ca17fef7066583b3f3d2cc876bca0",
              iosLicenseKey: "---iOS key---",
              resolution: Resolution.high)
          .then((value) {
        setState(() {});
      });
    } catch (e) {
      print('eororo ${e}');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: deepArController.isInitialized
            ? Container(
                width: MediaQuery.of(context).size.width,
                child: DeepArPreview(deepArController, onViewCreated: () {
                  print('fkakf');
                  deepArController.switchEffect('assets/glass.deepar');
                }),
              )
            : const Center(
                child: Text("Loading Preview"),
              ),
      ),
    );
  }
}
