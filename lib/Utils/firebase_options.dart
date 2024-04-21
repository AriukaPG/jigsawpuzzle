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
    apiKey: 'AIzaSyCHjbkLT9pPxE8kxQBVVvVLYuB5y3RQaJk',
    appId: '1:459072984986:web:dc0e81058e5c5565f28c23',
    messagingSenderId: '459072984986',
    projectId: 'puzzle-867ca',
    authDomain: 'puzzle-867ca.firebaseapp.com',
    storageBucket: 'puzzle-867ca.appspot.com',
    measurementId: 'G-ZH8LHH2QBN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKIc_d_OGci7nDogdDtN7LJSqhz1mzVfE',
    appId: '1:459072984986:android:d36d2e22fc873b7cf28c23',
    messagingSenderId: '459072984986',
    projectId: 'puzzle-867ca',
    storageBucket: 'puzzle-867ca.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOp7KBZ_NqdfK0hAaffHAUDmKd4ky8cnM',
    appId: '1:459072984986:ios:b0fc0f89e005bfcaf28c23',
    messagingSenderId: '459072984986',
    projectId: 'puzzle-867ca',
    storageBucket: 'puzzle-867ca.appspot.com',
    iosBundleId: 'com.example.jigsawpuzzle',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOp7KBZ_NqdfK0hAaffHAUDmKd4ky8cnM',
    appId: '1:459072984986:ios:b0fc0f89e005bfcaf28c23',
    messagingSenderId: '459072984986',
    projectId: 'puzzle-867ca',
    storageBucket: 'puzzle-867ca.appspot.com',
    iosBundleId: 'com.example.jigsawpuzzle',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCHjbkLT9pPxE8kxQBVVvVLYuB5y3RQaJk',
    appId: '1:459072984986:web:c2bcf574c00f4421f28c23',
    messagingSenderId: '459072984986',
    projectId: 'puzzle-867ca',
    authDomain: 'puzzle-867ca.firebaseapp.com',
    storageBucket: 'puzzle-867ca.appspot.com',
    measurementId: 'G-7CYPWRW3G2',
  );
}
