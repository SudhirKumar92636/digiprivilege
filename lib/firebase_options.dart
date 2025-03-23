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
    apiKey: 'AIzaSyDBp9b7FgMeYEPsv24VPPb_3iMaCsZ9qrY',
    appId: '1:436573396589:web:8fba145f03d0401c916964',
    messagingSenderId: '436573396589',
    projectId: 'fir-demo-project-57fd1',
    authDomain: 'fir-demo-project-57fd1.firebaseapp.com',
    databaseURL: 'https://fir-demo-project-57fd1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-demo-project-57fd1.appspot.com',
    measurementId: 'G-GHB5SP0C0C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5rzvIClgP9SAFQXZjWm-wvgJ9IhxxeqY',
    appId: '1:436573396589:android:152a0ca9530d109e916964',
    messagingSenderId: '436573396589',
    projectId: 'fir-demo-project-57fd1',
    databaseURL: 'https://fir-demo-project-57fd1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-demo-project-57fd1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3sNCWiuFmDW89yo54GM9wvN_dWn02boA',
    appId: '1:436573396589:ios:54e76f471be79f96916964',
    messagingSenderId: '436573396589',
    projectId: 'fir-demo-project-57fd1',
    databaseURL: 'https://fir-demo-project-57fd1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-demo-project-57fd1.appspot.com',
    androidClientId: '436573396589-jarjiua40n24s42gvl9gubqmo3qnt54u.apps.googleusercontent.com',
    iosClientId: '436573396589-19d0llmdij4ghr2ikabf78t0jbknp6sr.apps.googleusercontent.com',
    iosBundleId: 'com.example.membership',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3sNCWiuFmDW89yo54GM9wvN_dWn02boA',
    appId: '1:436573396589:ios:54e76f471be79f96916964',
    messagingSenderId: '436573396589',
    projectId: 'fir-demo-project-57fd1',
    databaseURL: 'https://fir-demo-project-57fd1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-demo-project-57fd1.appspot.com',
    androidClientId: '436573396589-jarjiua40n24s42gvl9gubqmo3qnt54u.apps.googleusercontent.com',
    iosClientId: '436573396589-19d0llmdij4ghr2ikabf78t0jbknp6sr.apps.googleusercontent.com',
    iosBundleId: 'com.example.membership',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDBp9b7FgMeYEPsv24VPPb_3iMaCsZ9qrY',
    appId: '1:436573396589:web:d88f39b0da1e04d0916964',
    messagingSenderId: '436573396589',
    projectId: 'fir-demo-project-57fd1',
    authDomain: 'fir-demo-project-57fd1.firebaseapp.com',
    databaseURL: 'https://fir-demo-project-57fd1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-demo-project-57fd1.appspot.com',
    measurementId: 'G-ZQZWFT98HR',
  );
}
