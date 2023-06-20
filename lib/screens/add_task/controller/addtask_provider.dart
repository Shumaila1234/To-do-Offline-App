import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:todo_offline_app/screens/home/controller/home_controller.dart';
import 'package:todo_offline_app/services/connectivity_manager.dart';
import 'package:todo_offline_app/utils/custom_imports.dart';

class AddTaskProvider {
  final dbHelper = DatabaseHelper.instance;
  final ConnectivityManager _connectivityManager = ConnectivityManager();

  Future<void> addTask(
      {String? taskTitle,
      String? date,
      String? time,
      BuildContext? context}) async {
    Map<String, dynamic> row = {
      DatabaseHelper.taskTitleCol: taskTitle.toString(),
      DatabaseHelper.dateCol: date,
      DatabaseHelper.timeCol: time,
    };
    if (await _connectivityManager.isInternetConnected()) {
      log("iff");
      // ScaffoldMessenger.of(context!)
      //   ..removeCurrentMaterialBanner()
      //   ..showMaterialBanner(
      //       Constants.showMaterialBanner(context, AppString.internetConnected));

      //if internet is connected then call addTaskApi, send data to server when succeed
      //then send data to Sqlite db.
      //  final insertQuery = await dbHelper.insert(row);
      final insertQueryByQuery =
          await dbHelper.insertByQuery(taskTitle, date, time);
      log('inserted row id: $insertQueryByQuery');
    } else {
      // ScaffoldMessenger.of(context!)
      //   ..removeCurrentMaterialBanner()
      //   ..showMaterialBanner(Constants.showMaterialBanner(
      //       context, AppString.internetDisconnected));
      // final insertQuery = await dbHelper.insert(row);
      final insertQueryByQuery =
          await dbHelper.insertByQuery(taskTitle, date, time);
      log('inserted row id: $insertQueryByQuery');
    }
    Provider.of<HomeProvider>(context!, listen: false).getAllData();

    ScaffoldMessenger.of(context)
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
          Constants.showMaterialBanner(context, AppString.taskCreatedMsg));
  }

  Future<void> editTask(
      {String? taskTitle,
      String? date,
      String? time,
      int? taskId,
      BuildContext? context}) async {
    Map<String, dynamic> row = {
      DatabaseHelper.taskTitleCol: taskTitle.toString(),
      DatabaseHelper.dateCol: date,
      DatabaseHelper.timeCol: time,
      DatabaseHelper.taskId: taskId,
    };
    // final dataEdited = await dbHelper.update(row);
    final dataEditedByQuery =
        await dbHelper.updateByQuery(taskTitle, date, time, taskId!);

    Provider.of<HomeProvider>(context!, listen: false).getAllData();

    ScaffoldMessenger.of(context)
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
          Constants.showMaterialBanner(context, AppString.taskEditMsg));

    // log('inserted row id: $id');
  }
}
