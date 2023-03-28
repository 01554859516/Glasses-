import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Color(0xff8A02AE),
            statusBarIconBrightness: Brightness.light),
        backgroundColor: const Color(0xff8A02AE),
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
          "Support",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.support_agent,
              size: 150,
              color: Colors.purple,
            ),
            Column(
              children: [
                Text(
                    "To contact support and for complaints, please use the following number",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
                InkWell(
                  onTap: () async {
                    String text = "Ineed help ihave some issue";
                    String url =
                        "https://wa.me/+2001554859516/?text=${Uri.encodeFull(text)}";
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text(
                    "01554859516",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.purple),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
