// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCtl1qFQH08cWj1jfLE_odVNTkUeyVn6U4',
    appId: '1:311266311690:web:e4a535a2d0ff90bb3ca9f3',
    messagingSenderId: '311266311690',
    projectId: 'push-9967c',
    authDomain: 'push-9967c.firebaseapp.com',
    storageBucket: 'push-9967c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCH7lEJRNOSZrUNtUNt35ojihUWD1XvL1A',
    appId: '1:311266311690:android:6c969da5c259ac283ca9f3',
    messagingSenderId: '311266311690',
    projectId: 'push-9967c',
    storageBucket: 'push-9967c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwNtO4vkp7LgK48h1NBo7OXA0cwjvkB4A',
    appId: '1:311266311690:ios:0c3d0fc951dc3d2c3ca9f3',
    messagingSenderId: '311266311690',
    projectId: 'push-9967c',
    storageBucket: 'push-9967c.appspot.com',
    iosBundleId: 'com.example.push',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCtl1qFQH08cWj1jfLE_odVNTkUeyVn6U4',
    appId: '1:311266311690:web:a36ed744de99ef6b3ca9f3',
    messagingSenderId: '311266311690',
    projectId: 'push-9967c',
    authDomain: 'push-9967c.firebaseapp.com',
    storageBucket: 'push-9967c.appspot.com',
  );
}