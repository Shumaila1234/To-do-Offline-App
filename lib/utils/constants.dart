import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:todo_offline_app/utils/app_navigations.dart';
import 'package:todo_offline_app/utils/custom_imports.dart';

class Constants {
  static Future<void> showSelectDatePicker(
      {BuildContext? context,
      final ValueChanged<String?>? getSelectedDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(2101),
        helpText: "Select Date",
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor, // header background color
                //onPrimary: Colors.black, // header text color
                //onSurface: Colors.green, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: AppColors.primaryColor, // button text color
                ),
              ),
            ),
            child: Hero(tag: "selectDate", child: child!),
          );
        });
    log("picked   $picked");
    if (picked != null) {
      getSelectedDate!(picked.toString().split(" ")[0]);
    }
  }

  static Future<void> showSelectTimePicker(
      {BuildContext? context,
      final ValueChanged<String?>? getSelectedDate}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context!,
    );
    if (pickedTime != null) {
      log("pickedTime  $pickedTime");

      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      log("parsedTime  $parsedTime");
      //converting to DateTime so that we can further format on different pattern.
      // log(parsedTime); //output 1970-01-01 22:53:00.000
      String formattedTime = DateFormat('HH:mm a').format(parsedTime);
      //DateFormat() is from intl package, you can format the time on any pattern you need.

      getSelectedDate!(formattedTime);
    } else {
      log("Time is not selected");
    }
  }

  static MaterialBanner showMaterialBanner(BuildContext context, String? msg) {
    return MaterialBanner(
        content: Text(msg ?? ""),
        leading: const Icon(Icons.error),
        padding: const EdgeInsets.all(15),
        backgroundColor: AppColors.lavendarColor,
        contentTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
        actions: [
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const CustomText(
                text: AppString.okTxt,
                fontColor: AppColors.primaryColor,
              )),
        ]);
  }

  static String formatDateTime(
      {required String parseFormat, required DateTime inputDateTime}) {
    // log("inputDateTime   $inputDateTime");
    return DateFormat(parseFormat).format(inputDateTime);
  }

  static String findLastDateOfTheWeek(DateTime dateTime) {
    return Constants.formatDateTime(
        parseFormat: AppString.DATE_MONTH_YEAR_FORMAT_YYYY_MM_DD,
        inputDateTime: dateTime
            .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday)));
    // return dateTime
    //     .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }
}
