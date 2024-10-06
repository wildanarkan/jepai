import 'package:flutter/material.dart';

class BuildButtonMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;

  const BuildButtonMenu({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: const Border.symmetric(
            horizontal: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: iconColor),
          ],
        ),
      ),
    );
  }
}
