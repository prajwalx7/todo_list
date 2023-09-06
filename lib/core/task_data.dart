class TaskData {
  final String task;
  final String description;
  final bool isDone;
  final DateTime? dueDate;

  TaskData({
    required this.task,
    required this.description,
    this.isDone = false,
    this.dueDate,
  });

  TaskData copyWith({
    String? task,
    String? description,
    bool? isDone,
    DateTime? dueDate,
  }) {
    return TaskData(
      task: task ?? this.task,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
