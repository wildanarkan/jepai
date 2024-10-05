import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  final GetStorage _storage = GetStorage(); // Mengakses GetStorage instance

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca data dari GetStorage
    String name = _storage.read('name') ?? 'No Name';
    String email = _storage.read('email') ?? 'No Email';
    String photoURL = _storage.read('photoURL') ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan Foto Profil
            if (photoURL.isNotEmpty)
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(photoURL),
              )
            else
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person),
              ),
            const SizedBox(height: 16),

            // Menampilkan Nama
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Menampilkan Email
            Text(
              email,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),

            // Tombol Logout
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await _storage.erase(); // Hapus semua data di GetStorage
                Get.offNamed('/introduction'); // Kembali ke halaman introduction
              },
              child: const Text('LOGOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
