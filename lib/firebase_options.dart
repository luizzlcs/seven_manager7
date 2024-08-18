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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBZTfJfQK4O3GtLNwCIJRhp4SyctVYhuEI',
    appId: '1:345781640769:web:7b268d566258692ee9f0c0',
    messagingSenderId: '345781640769',
    projectId: 'seven-manager-cffc7',
    authDomain: 'seven-manager-cffc7.firebaseapp.com',
    storageBucket: 'seven-manager-cffc7.appspot.com',
    measurementId: 'G-SK8W1E059E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOyP0et_rHPam11g3zCBpRXSzkifPlEIo',
    appId: '1:345781640769:android:b2ee96873727fc51e9f0c0',
    messagingSenderId: '345781640769',
    projectId: 'seven-manager-cffc7',
    storageBucket: 'seven-manager-cffc7.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBZTfJfQK4O3GtLNwCIJRhp4SyctVYhuEI',
    appId: '1:345781640769:web:45687ba61e1b5dbee9f0c0',
    messagingSenderId: '345781640769',
    projectId: 'seven-manager-cffc7',
    authDomain: 'seven-manager-cffc7.firebaseapp.com',
    storageBucket: 'seven-manager-cffc7.appspot.com',
    measurementId: 'G-SWRL0KQW1L',
  );

}