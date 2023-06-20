import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:todo_offline_app/screens/add_task/arguments/add_task_arguments.dart';
import 'package:todo_offline_app/screens/add_task/view/add_task_view.dart';
import 'package:todo_offline_app/screens/home/controller/home_controller.dart';
import 'package:todo_offline_app/utils/app_navigations.dart';
import 'package:todo_offline_app/utils/app_route_name.dart';
import 'package:todo_offline_app/utils/custom_imports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeProvider? _homeProvider;
  @override
  void initState() {
    super.initState();
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider?.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = Provider.of<HomeProvider>(context, listen: true);

    return Scaffold(
      appBar: customAppBarWidget(),
      body: _homeProvider!.isLoading
          ? customLoader()
          : _homeProvider!.isNoData
              ? customNoTaskFoundTxt()
              : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: AppPadding.screenPaddingTop,
                          left: AppPadding.screenPaddingLeft,
                          right: AppPadding.screenPaddingRight),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            todayText(),
                            todayNotesListWidget(),
                            sizedBox20(),
                            tommorrowText(),
                            tommorrowNotesListWidget(),
                            sizedBox20(),
                            thisWeekText(),
                            thisWeekNotesListWidget(),
                            sizedBox20(),
                          ])),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigation.navigateTo(context, AppRouteName.addTaskRoute,
              arguments: AddTaskArguments(
                isFromEdit: false,
              ));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  customNoTaskFoundTxt() {
    return const Center(
      child: CustomText(
        text: AppString.noTasksFound,
        fontWeight: FontWeight.bold,
        fontSize: AppPadding.homeHeadText,
      ),
    );
  }

  customLoader() {
    return const Center(child: CircularProgressIndicator());
  }

  customAppBarWidget() {
    return customAppBar(text: AppString.todoOffline);
  }

  todayText() {
    return const CustomText(
      text: AppString.today,
      fontWeight: FontWeight.bold,
      fontSize: AppPadding.homeHeadText,
    );
  }

  tommorrowText() {
    return const CustomText(
      text: AppString.tommorrow,
      fontWeight: FontWeight.bold,
      fontSize: AppPadding.homeHeadText,
    );
  }

  thisWeekText() {
    return const CustomText(
      text: AppString.thisWeek,
      fontWeight: FontWeight.bold,
      fontSize: AppPadding.homeHeadText,
    );
  }

  todayNotesListWidget() {
    return _homeProvider!.todayNotesData.isEmpty
        ? const Center(
            child: CustomText(
            text: AppString.noTaskForToday,
          ))
        : ListView.builder(
            itemCount: _homeProvider?.todayNotesData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CustomTaskContainer(
                  taskTitle: _homeProvider?.todayNotesData[index]['taskTitle'],
                  taskTime: _homeProvider?.todayNotesData[index]['time'],
                  onTapDeleteIcon: () {
                    _homeProvider?.deleteNote(
                        index: index,
                        type: AppString.today,
                        noteId: _homeProvider?.todayNotesData[index]['id']);
                  },
                  onTap: () {
                    AppNavigation.navigateTo(context, AppRouteName.addTaskRoute,
                        arguments: AddTaskArguments(
                            isFromEdit: true,
                            taskTitle: _homeProvider?.todayNotesData[index]
                                ['taskTitle'],
                            taskDate: _homeProvider?.todayNotesData[index]
                                ['date'],
                            taskTime: _homeProvider?.todayNotesData[index]
                                ['time'],
                            taskId: _homeProvider?.todayNotesData[index]
                                ['id']));
                  },
                ),
              );
            }));
  }

  tommorrowNotesListWidget() {
    return _homeProvider!.tommorrowNotesData.isEmpty
        ? const Center(
            child: CustomText(
            text: AppString.noTaskForTommorrow,
          ))
        : ListView.builder(
            itemCount: _homeProvider?.tommorrowNotesData.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CustomTaskContainer(
                  taskTitle: _homeProvider?.tommorrowNotesData[index]
                      ['taskTitle'],
                  taskTime: _homeProvider?.tommorrowNotesData[index]['time'],
                  onTapDeleteIcon: () {
                    _homeProvider?.deleteNote(
                        index: index,
                        type: AppString.tommorrow,
                        noteId: _homeProvider?.tommorrowNotesData[index]['id']);
                  },
                  onTap: () {
                    AppNavigation.navigateTo(context, AppRouteName.addTaskRoute,
                        arguments: AddTaskArguments(
                            isFromEdit: true,
                            taskTitle: _homeProvider?.tommorrowNotesData[index]
                                ['taskTitle'],
                            taskDate: _homeProvider?.tommorrowNotesData[index]
                                ['date'],
                            taskTime: _homeProvider?.tommorrowNotesData[index]
                                ['time'],
                            taskId: _homeProvider?.tommorrowNotesData[index]
                                ['id']));
                  },
                ),
              );
            }));
  }

  thisWeekNotesListWidget() {
    return ListView.builder(
        itemCount: _homeProvider?.thisWeekNotesData.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CustomTaskContainer(
              taskDate: _homeProvider?.thisWeekNotesData[index]['date'],
              taskTitle: _homeProvider?.thisWeekNotesData[index]['taskTitle'],
              taskTime: _homeProvider?.thisWeekNotesData[index]['time'],
              onTapDeleteIcon: () {
                _homeProvider?.deleteNote(
                    index: index,
                    type: AppString.thisWeek,
                    noteId: _homeProvider?.thisWeekNotesData[index]['id']);
              },
              onTap: () {
                AppNavigation.navigateTo(context, AppRouteName.addTaskRoute,
                    arguments: AddTaskArguments(
                        isFromEdit: true,
                        taskTitle: _homeProvider?.thisWeekNotesData[index]
                            ['taskTitle'],
                        taskDate: _homeProvider?.thisWeekNotesData[index]
                            ['date'],
                        taskTime: _homeProvider?.thisWeekNotesData[index]
                            ['time'],
                        taskId: _homeProvider?.thisWeekNotesData[index]['id']));
              },
            ),
          );
        }));
  }
}
