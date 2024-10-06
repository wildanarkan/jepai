import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';

import 'home/home_page.dart';
import 'profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final GetStorage _storage = GetStorage();
  late TabController _tabController;

  // Daftar halaman yang akan ditampilkan sesuai tab
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Tambahkan listener untuk mendeteksi perubahan tab
    _tabController.addListener(() {
      setState(() {}); // Memperbarui UI saat tab berubah
    });

    String name = _storage.read('name') ?? 'No Name';
    String email = _storage.read('email') ?? 'No Email';
    String photoURL = _storage.read('photoURL') ?? '';

    _pages = [
      const HomePage(),
      const Center(
        child: Text('Game Page'),
      ),
      const Center(
        child: Text('Achievement Page'),
      ),
      ProfilePage(photoURL: photoURL, name: name, email: email),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get current theme

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      bottomNavigationBar: GFTabBar(
        isScrollable: false,
        tabBarColor: theme.primaryColor,
        tabBarHeight: 50,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 1,
        length: 4,
        controller: _tabController,
        tabs: [
          Tab(
            icon: Icon(
              Icons.home,
              color: _tabController.index == 0
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              size: 20,
            ),
            child: Text(
              "Home",
              style: TextStyle(
                fontSize: 9,
                color: _tabController.index == 0
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.gamepad,
              color: _tabController.index == 1
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              size: 20,
            ),
            child: Text(
              "Game",
              style: TextStyle(
                fontSize: 9,
                color: _tabController.index == 1
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.menu_book_rounded,
              color: _tabController.index == 2
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              size: 20,
            ),
            child: Text(
              "Kamus",
              style: TextStyle(
                fontSize: 9,
                color: _tabController.index == 2
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.person,
              color: _tabController.index == 3
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              size: 20,
            ),
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 9,
                color: _tabController.index == 3
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}