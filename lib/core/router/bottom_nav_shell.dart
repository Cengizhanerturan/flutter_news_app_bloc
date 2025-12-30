import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/app_constants.dart';
import 'package:go_router/go_router.dart';

class BottomNavShell extends StatelessWidget {
  final StatefulNavigationShell shell;
  const BottomNavShell({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: shell.currentIndex,
        onTap: (index) => shell.goBranch(index),
        items: _navItems(context, shell.currentIndex),
      ),
    );
  }

  List<BottomNavigationBarItem> _navItems(
    BuildContext context,
    int currentIndex,
  ) {
    return List.generate(AppConstants.bottomNavLabels.length, (index) {
      final active = currentIndex == index;
      return BottomNavigationBarItem(
        icon: Image.asset(
          active
              ? AppConstants.bottomNavActiveIcons[index]
              : AppConstants.bottomNavIcons[index],
          width: 24,
          height: 24,
          color:
              active
                  ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
                  : Theme.of(
                    context,
                  ).bottomNavigationBarTheme.unselectedItemColor,
        ),
        label: AppConstants.bottomNavLabels[index],
      );
    });
  }
}
