import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/app_user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Current User Stream directly listening to Firebase Auth state
  Stream<AppUser?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((User? user) {
      if (user == null) return null;
      return AppUser(
        uid: user.uid,
        name: user.displayName ?? (user.email != null && user.email!.contains('@') ? user.email!.split('@')[0] : 'User'),
        email: user.email ?? '',
        photoUrl: user.photoURL,
        provider: user.providerData.any((p) => p.providerId == 'google.com') ? 'google' : 'email',
      );
    });
  }

  // Sign Up with Email & Password
  Future<AppUser> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await credential.user!.updateDisplayName(name);
        return AppUser(
          uid: credential.user!.uid,
          name: name,
          email: email,
          provider: 'email',
        );
      }
      throw Exception('Failed to create account.');
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase SignUp Error: ${e.code} - ${e.message}');
      throw Exception(e.message ?? 'Sign up failed (${e.code}).');
    } catch (e) {
      debugPrint('SignUp Error: $e');
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  // Log In with Email & Password
  Future<AppUser> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        return AppUser(
          uid: credential.user!.uid,
          name: credential.user!.displayName ?? (email.contains('@') ? email.split('@')[0] : 'User'),
          email: credential.user!.email ?? email,
          photoUrl: credential.user!.photoURL,
          provider: 'email',
        );
      }
      throw Exception('Login failed.');
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Login Error: ${e.code} - ${e.message}');
      throw Exception(e.message ?? 'Authentication failed (${e.code}).');
    } catch (e) {
      debugPrint('Login Error: $e');
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Sign In with Google (Web & Mobile platform-specific handling)
  Future<AppUser> signInWithGoogle() async {
    if (kIsWeb) {
      try {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        googleProvider.addScope('profile');
        
        final UserCredential userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        final User? user = userCredential.user;

        if (user != null) {
          return AppUser(
            uid: user.uid,
            name: user.displayName ?? (user.email != null && user.email!.contains('@') ? user.email!.split('@')[0] : 'Google User'),
            email: user.email ?? '',
            photoUrl: user.photoURL,
            provider: 'google',
          );
        }
        throw Exception('Google Sign In returned no user from Firebase.');
      } on FirebaseAuthException catch (e) {
        debugPrint('Firebase Web Auth Error: ${e.code} - ${e.message}');
        if (e.code == 'popup-closed-by-user') {
          throw Exception('Sign in popup was closed before completing.');
        } else if (e.code == 'unauthorized-domain') {
          throw Exception('Domain is not authorized in Firebase Console (Check authorized domains).');
        } else if (e.code == 'operation-not-allowed') {
          throw Exception('Google sign-in is not enabled in Firebase Console.');
        }
        throw Exception(e.message ?? 'Google Sign In failed (${e.code}).');
      } catch (e) {
        debugPrint('Google Web Sign-In Exception: $e');
        throw Exception('Google Sign In failed: ${e.toString()}');
      }
    } else {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          throw Exception('Google Sign In was cancelled by user.');
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          return AppUser(
            uid: user.uid,
            name: user.displayName ?? googleUser.displayName ?? 'Google User',
            email: user.email ?? googleUser.email,
            photoUrl: user.photoURL ?? googleUser.photoUrl,
            provider: 'google',
          );
        }
        throw Exception('Google Sign In failed on device.');
      } on FirebaseAuthException catch (e) {
        debugPrint('Firebase Mobile Auth Error: ${e.code} - ${e.message}');
        throw Exception(e.message ?? 'Google Sign In failed (${e.code}).');
      } catch (e) {
        debugPrint('Google Mobile Sign-In Exception: $e');
        throw Exception(e.toString().replaceAll('Exception: ', ''));
      }
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      if (!kIsWeb) {
        await _googleSignIn.signOut();
      }
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint('SignOut error: $e');
    }
  }
}
