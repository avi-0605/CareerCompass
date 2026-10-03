// File generated manually based on Firebase project credentials
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return ios;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCKSEh2leYB4siuy5eJm66xYINUSiEAfpg',
    appId: '1:147832218500:web:9a5fc127137278e2e3b3d1',
    messagingSenderId: '147832218500',
    projectId: 'careercompass-d1c69',
    authDomain: 'careercompass-d1c69.firebaseapp.com',
    storageBucket: 'careercompass-d1c69.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKSEh2leYB4siuy5eJm66xYINUSiEAfpg',
    appId: '1:147832218500:android:9a5fc127137278e2e3b3d1',
    messagingSenderId: '147832218500',
    projectId: 'careercompass-d1c69',
    storageBucket: 'careercompass-d1c69.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKSEh2leYB4siuy5eJm66xYINUSiEAfpg',
    appId: '1:147832218500:ios:9a5fc127137278e2e3b3d1',
    messagingSenderId: '147832218500',
    projectId: 'careercompass-d1c69',
    storageBucket: 'careercompass-d1c69.firebasestorage.app',
    iosBundleId: 'com.careercompass.careerCompass',
  );
}
