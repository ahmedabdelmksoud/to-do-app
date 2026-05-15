import 'package:to_doapp/model/task_model.dart';

class TaskService {
  /// Internal dummy task list
  final List<TaskModel> _tasks = [
    TaskModel(id: '1', title: 'Buy groceries', isCompleted: false),
    TaskModel(id: '2', title: 'Read a book for 30 minutes', isCompleted: true),
    TaskModel(id: '3', title: 'Go for a morning walk', isCompleted: false),
    TaskModel(id: '4', title: 'Review project proposal', isCompleted: false),
    TaskModel(id: '5', title: 'Call the dentist', isCompleted: true),
  ];

  /// Returns the full list of tasks
  List<TaskModel> getTasks() {
    return List.unmodifiable(_tasks);
  }

  /// Adds a new task to the list
  void addTask(String title) {
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );
    _tasks.add(newTask);
  }

  /// Toggles a task's completion status by ID
  void toggleTask(String id) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
  }
}
