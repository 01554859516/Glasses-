import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/cashehelper.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/config/endpoint.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/provider/cart.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/provider/google_singin.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/home_screen.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(onbackgroundmassging);
  Widget? widget;
  uid = CacheHelper.getData(key: 'uid');
  token = CacheHelper.getData(key: 'token');
  admin = CacheHelper.getData(key: 'admin');
  if (uid != null) {
    widget = admin == null ? const HomeScreen() : const AdiminHome();
  } else if (admin != null) {
    widget = const AdiminHome();
  } else {
    widget = const SplashSceen();
  }
  runApp(MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startwidget;
  MyApp({super.key, this.startwidget});
  final Color _primaryCololr = HexColor('#DC54FE');
  final Color _accentColor = HexColor('#8A02AE');
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Glasses Store',
          theme: ThemeData(
            primaryColor: _primaryCololr,
            scaffoldBackgroundColor: Colors.grey.shade100,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
                .copyWith(secondary: _accentColor),
          ),
          home: startwidget),
    );
  }
}

Future<void> onbackgroundmassging(RemoteMessage message) async {}
