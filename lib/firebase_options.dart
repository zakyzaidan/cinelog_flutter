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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCAInG4dCkxFhplMxfKCT0C_YjghdbMpr4',
    appId: '1:1018822041172:web:2df18ad7f4090bbcced7c1',
    messagingSenderId: '1018822041172',
    projectId: 'cinelog-312a0',
    authDomain: 'cinelog-312a0.firebaseapp.com',
    storageBucket: 'cinelog-312a0.appspot.com',
    measurementId: 'G-GB71B7LWB0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkNT84XZ2SCpAJlYlKz3nUlwQTBnaGvvs',
    appId: '1:1018822041172:android:3dd7f1100ac029c8ced7c1',
    messagingSenderId: '1018822041172',
    projectId: 'cinelog-312a0',
    storageBucket: 'cinelog-312a0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaY9GiPbDDPAaPO_KbJbir96mzBf8otnM',
    appId: '1:1018822041172:ios:b9ec6e1cfb054ea7ced7c1',
    messagingSenderId: '1018822041172',
    projectId: 'cinelog-312a0',
    storageBucket: 'cinelog-312a0.appspot.com',
    iosBundleId: 'com.example.cinelog',
  );
}