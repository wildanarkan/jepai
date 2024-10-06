import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jepai/widgets/button/build_button_menu.dart';

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
    final GetStorage storage = GetStorage();
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final iconColor = theme.iconTheme.color ?? Colors.black;

    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 2, child: _TopPortion(photoURL: photoURL)),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      BuildButtonMenu(
                        title: 'Settings',
                        icon: Icons.settings,
                        onTap: () => Get.toNamed('/profile/setting'),
                        iconColor: iconColor,
                        textColor: textColor,
                      ),
                      BuildButtonMenu(
                        title: 'About',
                        icon: Icons.info,
                        onTap: () => Get.toNamed('/profile/about'),
                        iconColor: iconColor,
                        textColor: textColor,
                      ),
                      BuildButtonMenu(
                        title: 'Help',
                        icon: Icons.help,
                        onTap: () => Get.toNamed('/profile/help'),
                        iconColor: iconColor,
                        textColor: textColor,
                      ),
                      BuildButtonMenu(
                        title: 'Feedback',
                        icon: Icons.feedback,
                        onTap: () => Get.toNamed('/profile/feedback'),
                        iconColor: iconColor,
                        textColor: textColor,
                      ),
                      BuildButtonMenu(
                        title: 'Logout',
                        icon: Icons.logout,
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          await storage.erase();
                          Get.offAllNamed('/introduction');
                        },
                        iconColor: iconColor,
                        textColor: textColor,
                      ),
                    ]
                        .expand(
                            (widget) => [widget, const SizedBox(height: 16)])
                        .toList()
                      ..removeLast(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  final String photoURL;

  const _TopPortion({required this.photoURL});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                theme.scaffoldBackgroundColor,
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (photoURL.isNotEmpty)
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(photoURL),
                  )
                else
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: theme.colorScheme.secondary,
                    child: Icon(
                      Icons.person,
                      color: theme.iconTheme.color,
                    ),
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
