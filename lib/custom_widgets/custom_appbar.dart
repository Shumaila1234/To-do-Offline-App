import 'package:flutter/material.dart';
import 'package:todo_offline_app/custom_widgets/custom_text.dart';
import 'package:todo_offline_app/utils/app_colors.dart';
import 'package:todo_offline_app/utils/app_padding.dart';

AppBar customAppBar({String? text}) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    title: CustomText(
      text: text ?? "",
      fontSize: AppPadding.appBarFontSize,
      fontColor: AppColors.lavendarColor,
    ),
  );
}
