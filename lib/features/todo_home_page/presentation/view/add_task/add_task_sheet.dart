import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/design-system/app_colors.dart';

import '../../../../../design-system/styles.dart';
import '../../../../../shared/app_constants.dart';
import '../../provider/task_provider.dart';
import 'sub_widgets/bottom_icons.dart';
import 'sub_widgets/input_fields.dart';

class NewTodoBottomSheet extends StatelessWidget {
   const NewTodoBottomSheet({super.key});


  @override
  Widget build(BuildContext context) {
    final provider = context.read<TaskProvider>();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: provider.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _topBar(),
                Spacing.h16,
                 InputFields(),
                Spacing.h20,
                 BottomActions(),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Column(
      children: [
        Container(
          height: 44.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Center(
            child: Text(
              "New To-Do",
              style: TextStyles.inter16Bold.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
