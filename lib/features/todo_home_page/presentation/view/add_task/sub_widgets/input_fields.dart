import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/todo_home_page/presentation/provider/task_provider.dart';
import 'package:todo/shared/extensions/text_field_extensions.dart';

class InputFields extends StatelessWidget {

  const InputFields({
    super.key,


  });

  @override
  Widget build(BuildContext context) {
    final provider= Provider.of<TaskProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: provider.titleController,
            validator: (value) => value?.isEmptyField(
              messageTitle: 'Task Name is required',
            ),            decoration: InputDecoration(
              hintText: 'eg : Meeting with client',
              border: InputBorder.none,
              hintStyle: TextStyles.inter16Regular.copyWith(
                color: kLightGreyColor,
              ),
            ),
            style: TextStyles.inter16Regular,
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            controller: provider.descriptionController,
            validator: (value) => value?.isEmptyField(
              messageTitle: 'Description is required',
            ),
            decoration: InputDecoration(
              hintText: 'Description',
              border: InputBorder.none,
              hintStyle: TextStyles.inter16Regular.copyWith(
                color: kLightGreyColor,
              ),
            ),
            style: TextStyles.inter16Regular,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}
