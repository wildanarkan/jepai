import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';  // Tambahkan ini
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'register_page.dart'; // Import halaman register

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  // Firestore instance

  String email = '';
  String password = '';

  Future<void> _signInWithGoogle() async {
    try {
      // Sign out to allow user to choose a different account
      await _googleSignIn.signOut();

      log('Starting Google Sign In process');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        log('Google Sign In was aborted by the user');
        return;
      }

      log('Google Sign In successful, obtaining auth details');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      log('Signing in to Firebase with Google credential');
      final userCredential = await _auth.signInWithCredential(credential);
      log('Firebase sign in successful');
      _onLoginSuccess(userCredential.user);
    } catch (e) {
      log('Error during Google sign in: $e');
      if (e is PlatformException) {
        log('Error code: ${e.code}');
        log('Error message: ${e.message}');
        log('Error details: ${e.details}');
      }
      // Handle error (show a snackbar, for example)
    }
  }

  Future<void> _signInWithEmail() async {
    try {
      // Melakukan sign in dengan email dan password
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _onLoginSuccess(userCredential.user);
    } catch (e) {
      log('Error during email sign in: $e');
      _showSnackbar('Failed to sign in. Please check your email and password.');
    }
  }

  void _onLoginSuccess(User? user) async {
    if (user != null) {
      // Save user data in GetStorage
      GetStorage().write('isLoggedIn', true);
      GetStorage().write('name', user.displayName ?? 'No Name');
      GetStorage().write('email', user.email ?? 'No Email');
      GetStorage().write('photoURL', user.photoURL ?? '');

      // Cek apakah user sudah ada di Firestore
      final userDoc = _firestore.collection('users').doc(user.uid);
      final userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        // Jika user belum ada, simpan data baru ke Firestore
        userDoc.set({
          'name': user.displayName ?? 'No Name',
          'email': user.email,
          'photoURL': user.photoURL,
          'createdAt': FieldValue.serverTimestamp(),  // Simpan waktu pembuatan akun
        });
      }

      // Navigate to home screen
      Get.offNamed('/home');
    }
  }

  void _showSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                email = value; // Simpan email
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) {
                password = value; // Simpan password
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _signInWithEmail,
              child: const Text('Login with Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: const Text('Login with Google'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.to(() => const RegisterPage()); // Navigasi ke halaman register
              },
              child: const Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
