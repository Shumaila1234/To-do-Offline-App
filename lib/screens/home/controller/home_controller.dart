import 'dart:developer';

import 'package:todo_offline_app/utils/custom_imports.dart';

class HomeProvider with ChangeNotifier {
  bool isNoData = false;
  List notesData = [];
  List todayNotesData = [];
  List tommorrowNotesData = [];
  List thisWeekNotesData = [];
  final dbHelper = DatabaseHelper.instance;
  final now = DateTime.now();
  final String _currentDate = Constants.formatDateTime(
      parseFormat: AppString.DATE_MONTH_YEAR_FORMAT_YYYY_MM_DD,
      inputDateTime: DateTime.now());

  final lastDateOfCurrentWeek = Constants.findLastDateOfTheWeek(DateTime.now());

  final tomorrow = Constants.formatDateTime(
      parseFormat: AppString.DATE_MONTH_YEAR_FORMAT_YYYY_MM_DD,
      inputDateTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));

  bool isLoading = true;

  void getAllData() async {
    notesData.clear();
    todayNotesData.clear();
    tommorrowNotesData.clear();
    thisWeekNotesData.clear();
    var allRows = await queryAllRecords();

    if (allRows != null) {
      isLoading = false;

      allRows.forEach((row) async {
        isNoData = false;
        if (row['date'] == _currentDate) {
          todayNotesData.add(row);
        } else if (row['date'] == tomorrow) {
          tommorrowNotesData.add(row);
        } else if (row['date'].compareTo(lastDateOfCurrentWeek) <= 0) {
          thisWeekNotesData.add(row);
        } else {
          notesData.add(row);
        }
      });
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  Future<void> deleteNote({int? noteId, String? type, int? index}) async {
    // var delete = await dbHelper.delete(noteId!);
    var delete = await dbHelper.deleteByQuery(noteId!);
    if (delete == 1) {
      if (type == AppString.today) {
        todayNotesData.removeAt(index!);
      } else if (type == AppString.tommorrow) {
        tommorrowNotesData.removeAt(index!);
      } else {
        thisWeekNotesData.removeAt(index!);
      }
    }
    notifyListeners();
    log("delete  $delete");
  }

  Future<dynamic> queryAllRecords() async {
    final allData = await dbHelper.queryAllRecords();
    if (allData.isEmpty) {
      isNoData = true;
    }
    notifyListeners();
    return allData;
  }
}
