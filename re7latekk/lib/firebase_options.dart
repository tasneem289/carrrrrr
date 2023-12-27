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
    apiKey: 'AIzaSyAAZLnJa-ZIS1pZH-4taz3I7PeOvTHNuFM',
    appId: '1:440358669301:web:102632905a0ba551e16ebc',
    messagingSenderId: '440358669301',
    projectId: 're7la-app',
    authDomain: 're7la-app.firebaseapp.com',
    storageBucket: 're7la-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAW64ub4Qt9vfu1qDzm7QKTka9Ybu5qkTA',
    appId: '1:440358669301:android:b07ac75351c98cc5e16ebc',
    messagingSenderId: '440358669301',
    projectId: 're7la-app',
    storageBucket: 're7la-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACriEJss-rRmATnhOb1Fo2sGteZLlb-CQ',
    appId: '1:440358669301:ios:e32638d60fd80aa2e16ebc',
    messagingSenderId: '440358669301',
    projectId: 're7la-app',
    storageBucket: 're7la-app.appspot.com',
    iosBundleId: 'com.example.re7latekk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACriEJss-rRmATnhOb1Fo2sGteZLlb-CQ',
    appId: '1:440358669301:ios:7b33663bf37744cbe16ebc',
    messagingSenderId: '440358669301',
    projectId: 're7la-app',
    storageBucket: 're7la-app.appspot.com',
    iosBundleId: 'com.example.re7latekk.RunnerTests',
  );
}