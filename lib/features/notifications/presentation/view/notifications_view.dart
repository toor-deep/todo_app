import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';

import '../../../../shared/app_constants.dart';

class NotificationsView extends StatelessWidget {
  static const String path = '/notifications';
  static const String name = 'notifications';

  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyles.inter24Semi.copyWith(color: Colors.black),
        ),
      ),
      body: _listview(),
    );
  }

  Widget _listview() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return _item();
        },
      ),
    );
  }

  Widget _item() {
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
                '🔔 Reminder',
                style: TextStyles.inter16Semi.copyWith(color: Colors.black),
              ),
              Spacing.h8,
              Text(
                "Don't forget to complete Alex Interview before the deadline.",
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
