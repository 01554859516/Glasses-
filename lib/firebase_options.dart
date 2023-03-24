// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA-5d5O4qurXdJCBSxHX9A4VhOhEhfCBf4',
    appId: '1:74550325964:web:d687ce8168d29b6ad24869',
    messagingSenderId: '74550325964',
    projectId: 'glasses-store-65124',
    authDomain: 'glasses-store-65124.firebaseapp.com',
    storageBucket: 'glasses-store-65124.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoEE282xM3Hksi7ANwY7brbErDg8UJI8Q',
    appId: '1:74550325964:android:c432d0eb88f5971fd24869',
    messagingSenderId: '74550325964',
    projectId: 'glasses-store-65124',
    storageBucket: 'glasses-store-65124.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaL-wQxLf6cUPtrtlokSlkAGbhS0oa8MA',
    appId: '1:74550325964:ios:c9b21ed09965a617d24869',
    messagingSenderId: '74550325964',
    projectId: 'glasses-store-65124',
    storageBucket: 'glasses-store-65124.appspot.com',
    androidClientId: '74550325964-rjk7lbrfnbikqllmmtjjg9i53v9efrbc.apps.googleusercontent.com',
    iosClientId: '74550325964-p01guhohvsihg0c5ncdb2949661u038e.apps.googleusercontent.com',
    iosBundleId: 'com.example.glassesstore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCaL-wQxLf6cUPtrtlokSlkAGbhS0oa8MA',
    appId: '1:74550325964:ios:c9b21ed09965a617d24869',
    messagingSenderId: '74550325964',
    projectId: 'glasses-store-65124',
    storageBucket: 'glasses-store-65124.appspot.com',
    androidClientId: '74550325964-rjk7lbrfnbikqllmmtjjg9i53v9efrbc.apps.googleusercontent.com',
    iosClientId: '74550325964-p01guhohvsihg0c5ncdb2949661u038e.apps.googleusercontent.com',
    iosBundleId: 'com.example.glassesstore',
  );
}
