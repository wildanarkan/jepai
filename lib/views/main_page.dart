import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';

import 'home_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  final GetStorage _storage = GetStorage();
  late TabController _tabController;

  // Daftar halaman yang akan ditampilkan sesuai tab
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Membaca data dari GetStorage
    String name = _storage.read('name') ?? 'No Name';
    String email = _storage.read('email') ?? 'No Email';
    String photoURL = _storage.read('photoURL') ?? '';

    // Halaman Home dan Profile
    _pages = [
      const HomePage(), // Halaman Home dipisahkan di file home_page.dart
      ProfilePage(photoURL: photoURL, name: name, email: email), // Halaman Profile dari file profile_page.dart
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,  // Menghubungkan TabController dengan TabBarView
        children: _pages,  // Menampilkan halaman sesuai dengan tab yang dipilih
      ),
      bottomNavigationBar: GFTabBar(
        isScrollable: false,
        tabBarColor: Colors.blue,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabBarHeight: 50,
        length: 2, // Sesuai dengan jumlah halaman
        controller: _tabController, // Menggunakan TabController untuk mengontrol tab
        tabs: const [
          Tab(
            icon: Icon(
              Icons.directions_bike,
              size: 20, // Mengubah ukuran ikon
            ),
            child: Text(
              "Home",
              style: TextStyle(fontSize: 9), // Mengubah ukuran font label
            ),
          ),
          Tab(
            icon: Icon(
              Icons.person,
              size: 20, // Mengubah ukuran ikon
            ),
            child: Text(
              "Profile",
              style: TextStyle(fontSize: 9), // Mengubah ukuran font label
            ),
          ),
        ],
      ),
    );
  }
}
