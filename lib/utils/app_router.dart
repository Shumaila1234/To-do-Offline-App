import 'package:flutter/material.dart';
import 'package:todo_offline_app/screens/add_task/arguments/add_task_arguments.dart';
import 'package:todo_offline_app/screens/add_task/view/add_task_view.dart';
import 'package:todo_offline_app/screens/home/view/home_view.dart';
import 'package:todo_offline_app/utils/app_route_name.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case AppRouteName.homeViewRoute:
            return const HomeView();

          case AppRouteName.addTaskRoute:
            AddTaskArguments? addTaskArguments =
                routeSettings.arguments as AddTaskArguments?;
            return AddTaskView(
              isFromEdit: addTaskArguments?.isFromEdit ?? false,
              taskTitle: addTaskArguments?.taskTitle ?? "",
              taskDate: addTaskArguments?.taskDate ?? "",
              taskTime: addTaskArguments?.taskTime ?? "",
              taskId: addTaskArguments?.taskId ?? 0,
            );

          default:
            return Container();
        }
      },
    );
  }
}
