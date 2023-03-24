 import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> localnotifications() async {
    var andriodinailze =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationsettingdSettings =
        InitializationSettings(android: andriodinailze);
    flutterLocalNotificationsPlugin.initialize(initializationsettingdSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidNotificationspecfic =
          AndroidNotificationDetails('2', '2','2',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);
      NotificationDetails platfromchanelspecifics =
          NotificationDetails(android: androidNotificationspecfic);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platfromchanelspecifics,
          payload: message.data['body']);
    });
  }