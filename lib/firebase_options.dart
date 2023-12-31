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
    apiKey: 'AIzaSyD-94aaGyrCLiA7ct6pDsyEfNp07VDuJJc',
    appId: '1:170665112578:web:615394f3c34ecc2a3c631b',
    messagingSenderId: '170665112578',
    projectId: 'jobs-76d4c',
    authDomain: 'jobs-76d4c.firebaseapp.com',
    storageBucket: 'jobs-76d4c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCd98SxdbWT9fRdXKy1ZaRwm1wRAGc64r8',
    appId: '1:170665112578:android:443896d1cd87e8573c631b',
    messagingSenderId: '170665112578',
    projectId: 'jobs-76d4c',
    storageBucket: 'jobs-76d4c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD62NpfkJMt9JNEeqDq_OgUPSYmycQARLY',
    appId: '1:170665112578:ios:1a5e564923eb2ebb3c631b',
    messagingSenderId: '170665112578',
    projectId: 'jobs-76d4c',
    storageBucket: 'jobs-76d4c.appspot.com',
    iosBundleId: 'com.example.job',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD62NpfkJMt9JNEeqDq_OgUPSYmycQARLY',
    appId: '1:170665112578:ios:11022ef4dae6b1663c631b',
    messagingSenderId: '170665112578',
    projectId: 'jobs-76d4c',
    storageBucket: 'jobs-76d4c.appspot.com',
    iosBundleId: 'com.example.job.RunnerTests',
  );
}
