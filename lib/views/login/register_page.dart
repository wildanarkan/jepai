import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email = '';
  String password = '';
  String name = ''; // Field untuk nama

  Future<void> _registerWithEmail() async {
    try {
      // Melakukan registrasi dengan email dan password
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Setelah registrasi berhasil, simpan data pengguna
      await _saveUserData(userCredential.user);
      _onRegisterSuccess(userCredential.user);
    } catch (e) {
      log('Error during email registration: $e');
      _showSnackbar('Failed to register. Please try again.');
    }
  }

  Future<void> _saveUserData(User? user) async {
    if (user != null) {
      // Menyimpan data pengguna ke Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,  // Simpan nama
        'email': user.email,
        'photoURL': user.photoURL ?? '',
      });
    }
  }

  void _onRegisterSuccess(User? user) {
    if (user != null) {
      // Save user data in GetStorage
      GetStorage().write('isLoggedIn', true);
      GetStorage().write('name', name); // Simpan nama di GetStorage
      GetStorage().write('email', user.email ?? 'No Email');
      GetStorage().write('photoURL', user.photoURL ?? '');

      // Navigate to home screen
      Get.offNamed('/main');
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
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                name = value; // Simpan nama
              },
            ),
            const SizedBox(height: 16),
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
              onPressed: _registerWithEmail,
              child: const Text('Register'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.back(); // Kembali ke halaman login
              },
              child: const Text('Already have an account? Login here'),
            ),
          ],
        ),
      ),
    );
  }
}
