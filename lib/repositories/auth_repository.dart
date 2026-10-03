import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/app_user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Helper method for clean human-readable Firebase Auth error messages
  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'Invalid email or password. If you do not have an account, please click "Sign Up" below.';
      case 'email-already-in-use':
        return 'An account already exists with this email address. Please log in instead.';
      case 'invalid-email':
        return 'The email address format is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please use at least 6 characters.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'too-many-requests':
        return 'Too many failed login attempts. Please wait a moment and try again.';
      case 'operation-not-allowed':
        return 'This sign-in provider is not enabled in Firebase Console.';
      case 'popup-closed-by-user':
        return 'Google Sign-In popup was closed before completing.';
      case 'unauthorized-domain':
        return 'Domain is not authorized for OAuth in Firebase Console Settings.';
      case 'network-request-failed':
        return 'Network connection error. Please check your internet connection.';
      default:
        return e.message ?? 'Authentication error (${e.code}).';
    }
  }

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
      throw Exception(_mapFirebaseAuthError(e));
    } catch (e) {
      debugPrint('SignUp Error: $e');
      throw Exception('Sign up failed: ${e.toString().replaceAll('Exception: ', '')}');
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
      throw Exception(_mapFirebaseAuthError(e));
    } catch (e) {
      debugPrint('Login Error: $e');
      throw Exception('Login failed: ${e.toString().replaceAll('Exception: ', '')}');
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
        throw Exception(_mapFirebaseAuthError(e));
      } catch (e) {
        debugPrint('Google Web Sign-In Exception: $e');
        throw Exception('Google Sign In failed: ${e.toString().replaceAll('Exception: ', '')}');
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
        throw Exception(_mapFirebaseAuthError(e));
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
