import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String photoURL;
  final String name;
  final String email;

  const ProfilePage({
    super.key,
    required this.photoURL,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'), // Judul AppBar untuk Profile
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
          ],
        ),
      ),
    );
  }
}
