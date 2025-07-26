import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/notifications/presentation/provider/notification_provider.dart';

import '../../../../shared/app_constants.dart';
import '../../domain/enityt/notification_entity.dart';

class NotificationsView extends StatefulWidget {
  static const String path = '/notifications';
  static const String name = 'notifications';

  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().loadNotifications();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, value, child) {
        return  Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Notifications',
              style: TextStyles.inter24Semi.copyWith(color: Colors.black),
            ),
          ),
          body: _listview(value.notifications),
        );
      },
    );
  }

  Widget _listview(List<NotificationEntity> list) {
    if(list.isEmpty){
      return Center(
        child: Text(
          'No notifications available',
          style: TextStyles.inter16Regular.copyWith(color: kLightGreyColor),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _item(list[index]);
        },
      ),
    );
  }

  Widget _item(NotificationEntity item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kLightGreyColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: TextStyles.inter16Semi.copyWith(color: Colors.black),
              ),
              Spacing.h8,
              Text(
                item.body,
                style: TextStyles.inter14Regular.copyWith(
                  color: kLightGreyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
