import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/shared/app_icons.dart';

import '../../shared/app_constants.dart';
import 'custom_bottom_navigation/provider/bottom_navigation_provider.dart';

class BottomNavBar extends StatelessWidget {
  static String path = "/bottom-view";
  static String name = "bottom-view";

  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottomNavigationProvider>(context);
    final selectedIndex = navProvider.selectedIndex;
    final items = navProvider.items;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: items[selectedIndex].view,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: navProvider.updateNavigationIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          selectedLabelStyle:
          TextStyles.inter12Regular.copyWith(color: kPrimaryColor),
          unselectedLabelStyle:
          TextStyles.inter12Regular.copyWith(color: kGreyDarkColor),
          iconSize: 24,
        items: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = selectedIndex == index;

          return BottomNavigationBarItem(
            icon: Column(
              children: [
                AppIcon(
                  item.selectedAppIcon,
                  color: isSelected ? kPrimaryColor : kGreyDarkColor,
                ),
                Spacing.h4,
              ],
            ),
            label: item.title,
            backgroundColor: Colors.white,
          );
        }).toList(),

      ),

    );
  }
}
