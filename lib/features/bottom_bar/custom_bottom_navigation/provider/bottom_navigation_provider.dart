import 'package:flutter/cupertino.dart';
import 'package:todo/features/calendar/presentation/view/calendar_view.dart';
import 'package:todo/features/notifications/presentation/view/notifications_view.dart';
import 'package:todo/features/profile/presentation/view/profile_view.dart';
import 'package:todo/features/todo_home_page/presentation/view/todo_home_page.dart';

import '../../../../shared/app_icons.dart';
import '../modal/bottom_navigation_item_modal.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int selectedIndex = 0;
  String? roleType = 'buyer';
  bool isBottomBarVisible = true;

  List<ItemData> items = [
    ItemData(
      id: 0,
      view: const ToDoHomePage(),
      title: "Home",
      selectedAppIcon: AppIcons.home,
    ),
    ItemData(
      id: 1,
      view: const NotificationsView(),
      title: 'Notifications',
      selectedAppIcon: AppIcons.bell,
    ),
    ItemData(
      id: 2,
      view: const CalendarView(),
      title: 'Calendar',
      selectedAppIcon: AppIcons.calendar,
    ),
    ItemData(
      id: 3,
      view:  ProfileView(),
      title: "Profile",
      selectedAppIcon: AppIcons.user,
    ),
  ];

  void updateNavigationIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
