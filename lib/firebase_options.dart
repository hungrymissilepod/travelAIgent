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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWPjumGxiCz7JRwtkB8T6JB3SQAMYnVc0',
    appId: '1:77290258797:android:4fc6dae1925d309caada64',
    messagingSenderId: '77290258797',
    projectId: 'travelaigent-b6459',
    databaseURL: 'https://travelaigent-b6459-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'travelaigent-b6459.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTlqafRyWby20-QijHTjE-DkiTjlZN5_w',
    appId: '1:77290258797:ios:34ec390e7959a498aada64',
    messagingSenderId: '77290258797',
    projectId: 'travelaigent-b6459',
    databaseURL: 'https://travelaigent-b6459-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'travelaigent-b6459.appspot.com',
    iosClientId: '77290258797-4tu16jejolva4m920j9gsa75jmrred3j.apps.googleusercontent.com',
    iosBundleId: 'com.kingly.travelaigent',
  );
}
