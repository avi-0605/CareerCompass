import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../main_navigation_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // If local session is active, grant access to Home immediately
    if (authProvider.isLoggedIn) {
      return const MainNavigationScreen();
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFF7F5F0),
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF18181B),
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return const MainNavigationScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
