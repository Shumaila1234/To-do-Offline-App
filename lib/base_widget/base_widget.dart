import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_offline_app/screens/home/controller/home_controller.dart';
import 'package:todo_offline_app/screens/home/view/home_view.dart';
import 'package:todo_offline_app/utils/app_colors.dart';
import 'package:todo_offline_app/utils/app_router.dart';
import 'package:todo_offline_app/utils/app_strings.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        title: AppString.appTitle,
        theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            primarySwatch: AppColors.kPrimaryColor,
            scaffoldBackgroundColor: AppColors.lavendarColor),
        home: const HomeView(),
      ),
    );
  }
}
