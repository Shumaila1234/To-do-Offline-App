import 'dart:developer';

import 'package:todo_offline_app/custom_widgets/custom_button.dart';
import 'package:todo_offline_app/screens/add_task/controller/addtask_provider.dart';
import 'package:todo_offline_app/utils/constants.dart';
import 'package:todo_offline_app/utils/custom_imports.dart';
import 'package:todo_offline_app/utils/field_validators.dart';

class AddTaskView extends StatefulWidget {
  final bool? isFromEdit;
  final String? taskTitle;
  final String? taskDate;
  final String? taskTime;
  final int? taskId;
  const AddTaskView(
      {super.key,
      this.isFromEdit,
      this.taskTitle,
      this.taskDate,
      this.taskTime,
      this.taskId});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final AddTaskProvider _addTaskProvider = AddTaskProvider();
  final _createTaskFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isFromEdit == true) {
      setState(() {
        _taskTitleController.text = widget.taskTitle!;
        _startDateController.text = widget.taskDate!;
        _startTimeController.text = widget.taskTime!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.screenPaddingTop,
            left: AppPadding.screenPaddingLeft,
            right: AppPadding.screenPaddingRight),
        child: SingleChildScrollView(
          child: Form(
            key: _createTaskFormKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              taskTitleField(),
              sizedBox10(),
              dueDateTxt(),
              _dateTextField(
                  hintText: AppString.startDate,
                  textEditingController: _startDateController,
                  onTap: () {}),
              _timeTextField(
                  hintText: AppString.startTime,
                  textEditingController: _startTimeController,
                  onTap: () {}),
              sizedBox20(),
              sizedBox10(),
              customButtonWidget()
            ]),
          ),
        ),
      ),
    );
  }

  customAppBarWidget() {
    return customAppBar(
        text:
            widget.isFromEdit == true ? AppString.editTask : AppString.addTask);
  }

  taskTitleField() {
    return CustomTextfield(
      controller: _taskTitleController,
      borderColor: AppColors.primaryColor,
      hintText: AppString.taskFieldHintTxt,
      labelText: AppString.taskFieldLableTxt,
      validator: (value) => value?.validateEmpty(AppString.titleReq),
    );
  }

  dueDateTxt() {
    return const CustomText(
      text: AppString.dueDate,
      fontColor: AppColors.primaryColor,
      fontSize: AppPadding.appTextHeadingFontSize,
    );
  }

  Future<void> _showDatePicker(TextEditingController? textEditingController) {
    return Constants.showSelectDatePicker(
        context: context,
        getSelectedDate: (v) {
          setState(() {
            _startDateController.text = v.toString();
          });
        });
  }

  Future<void> _showTimePicker(TextEditingController? textEditingController) {
    return Constants.showSelectTimePicker(
        context: context,
        getSelectedDate: (v) {
          setState(() {
            _startTimeController.text = v.toString();
          });
        });
  }

  Widget _dateTextField(
      {String? hintText,
      TextEditingController? textEditingController,
      Function? onTap}) {
    return CustomTextfield(
      isPrefixIcon: true,
      isBorder: true,
      controller: textEditingController,
      suffixIcon: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            _showDatePicker(textEditingController);
          },
          child: const Icon(
            Icons.calendar_month,
            color: AppColors.primaryColor,
          )),
      onTap: () {
        _showDatePicker(textEditingController);
      },
      bgColor: AppColors.transparentColor,
      hintText: hintText ?? "",
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      isReadOnly: true,
      isSuffixIcon: true,
      validator: (value) => value?.validateEmpty(AppString.date),
    );
  }

  Widget _timeTextField(
      {String? hintText,
      TextEditingController? textEditingController,
      Function? onTap}) {
    return CustomTextfield(
      isPrefixIcon: true,
      isBorder: true,
      controller: textEditingController,
      suffixIcon: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            _showTimePicker(textEditingController);
          },
          child: const Icon(
            Icons.timer_outlined,
            color: AppColors.primaryColor,
          )),
      onTap: () {
        _showTimePicker(textEditingController);
      },
      bgColor: AppColors.transparentColor,
      hintText: hintText ?? "",
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      isReadOnly: true,
      isSuffixIcon: true,
      validator: (value) => value?.validateEmpty(AppString.time),
    );
  }

  customButtonWidget() {
    return CustomButton(
      text: widget.isFromEdit == true ? AppString.editTask : AppString.addTask,
      onTap: () {
        if (widget.isFromEdit == true) {
          editTaskMethod();
        } else {
          createTaskMethod();
        }
      },
    );
  }

  createTaskMethod() {
    if (_createTaskFormKey.currentState!.validate()) {
      _addTaskProvider.addTask(
          taskTitle: _taskTitleController.text,
          date: _startDateController.text,
          time: _startTimeController.text,
          context: context);
    }
  }

  editTaskMethod() {
    if (_createTaskFormKey.currentState!.validate()) {
      _addTaskProvider.editTask(
          taskTitle: _taskTitleController.text,
          date: _startDateController.text,
          time: _startTimeController.text,
          taskId: widget.taskId,
          context: context);
    }
  }
}
