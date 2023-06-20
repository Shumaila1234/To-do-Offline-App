class AddTaskArguments {
  final bool? isFromEdit;
  final String? taskTitle;
  final String? taskDate;
  final String? taskTime;
  final int? taskId;

  AddTaskArguments(
      {this.isFromEdit,
      this.taskTitle,
      this.taskDate,
      this.taskTime,
      this.taskId});
}
