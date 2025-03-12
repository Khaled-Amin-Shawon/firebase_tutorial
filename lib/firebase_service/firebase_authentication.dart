import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up Method
  Future<Map<String, dynamic>> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        if (kDebugMode) {
          print("User created successfully: ${userCredential.user!.uid}");
        }
        return {'success': true, 'uid': userCredential.user!.uid};
      } else {
        return {'success': false, 'message': 'User creation failed.'};
      }
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'message': _handleAuthException(e)};
    } catch (e) {
      return {'success': false, 'message': 'An unexpected error occurred: $e'};
    }
  }

  // Sign In Method
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        if (kDebugMode) {
          print("User signed in successfully: ${userCredential.user!.uid}");
        }
        return {'success': true, 'uid': userCredential.user!.uid};
      } else {
        return {'success': false, 'message': 'Sign-in failed.'};
      }
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'message': _handleAuthException(e)};
    } catch (e) {
      return {'success': false, 'message': 'An unexpected error occurred: $e'};
    }
  }

  // Sign Out Method
  Future<Map<String, dynamic>> signOut() async {
    try {
      await _auth.signOut();
      if (kDebugMode) {
        print('User signed out successfully.');
      }
      return {'success': true, 'message': 'User signed out successfully.'};
    } catch (e) {
      return {'success': false, 'message': 'Sign out failed: $e'};
    }
  }

  // Error Handling
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
