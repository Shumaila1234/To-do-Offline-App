import 'package:flutter/material.dart';
import 'package:todo_offline_app/utils/custom_imports.dart';

class CustomTaskContainer extends StatelessWidget {
  final String? taskTitle;
  final String? taskDate;
  final String? taskTime;
  final Function()? onTapDeleteIcon;
  final Function()? onTap;

  const CustomTaskContainer(
      {super.key,
      this.taskTitle,
      this.taskDate,
      this.taskTime,
      this.onTapDeleteIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor),
        child: ListTile(
          leading: const Icon(
            Icons.check_box_outline_blank_sharp,
            color: AppColors.lavendarColor,
          ),
          title: CustomText(
            text: taskTitle?.capitalize() ?? "",
            fontColor: AppColors.lavendarColor,
            fontSize: 20,
          ),
          subtitle: CustomText(
            text:
                taskDate != null ? "$taskDate , $taskTime" : "Today  $taskTime",
            fontColor: AppColors.lavendarColor,
            fontSize: 12,
          ),
          trailing: InkWell(
            onTap: onTapDeleteIcon,
            child: const Icon(
              Icons.delete,
              color: AppColors.lavendarColor,
            ),
          ),
        ),
      ),
    );
  }
}
