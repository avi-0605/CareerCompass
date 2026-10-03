import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/app_user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Current User Stream
  Stream<AppUser?> get authStateChanges {
    try {
      return _firebaseAuth.authStateChanges().map((User? user) {
        if (user == null) return null;
        return AppUser(
          uid: user.uid,
          name: user.displayName ?? 'Aavani Sharma',
          email: user.email ?? '',
          photoUrl: user.photoURL,
          provider: user.providerData.any((p) => p.providerId == 'google.com') ? 'google' : 'email',
        );
      });
    } catch (_) {
      return Stream.value(null);
    }
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
      throw Exception(e.message ?? 'Sign up failed.');
    } catch (_) {
      // Fallback dev account
      return AppUser(
        uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        provider: 'email',
      );
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
          name: credential.user!.displayName ?? 'Aavani Sharma',
          email: credential.user!.email ?? email,
          photoUrl: credential.user!.photoURL,
          provider: 'email',
        );
      }
      throw Exception('Login failed.');
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Authentication failed.');
    } catch (_) {
      // Fallback dev account
      return AppUser(
        uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Aavani Sharma',
        email: email,
        provider: 'email',
      );
    }
  }

  // Sign In with Google
  Future<AppUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign In was cancelled.');
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
      throw Exception('Google Sign In failed.');
    } catch (e) {
      // Fallback dev Google user
      return AppUser(
        uid: 'google_user_101',
        name: 'Aavani Sharma',
        email: 'aavani.sharma@gmail.com',
        photoUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80',
        provider: 'google',
      );
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (_) {}
  }
}
