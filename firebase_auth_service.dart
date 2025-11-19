// lib/services/firebase_auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- Register a new user with email and password ---
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Registration Error: ${e.code} - ${e.message}');
      // You can throw the exception or return null, depending on how you want to handle it
      // For simplicity, we'll rethrow for the UI to catch
      rethrow;
    } catch (e) {
      print('Unknown Registration Error: $e');
      rethrow;
    }
  }

  // --- Sign in an existing user with email and password ---
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Login Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unknown Login Error: $e');
      rethrow;
    }
  }

  // --- Sign out the current user ---
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign Out Error: $e');
    }
  }

  // --- Get the current user ---
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // --- Listen to auth state changes ---
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}