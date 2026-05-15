import 'package:flutter/material.dart';
import 'package:to_doapp/model/task_model.dart';
import 'package:to_doapp/screens/add_task.dart';
import '../services/task_service.dart';
import '../widgets/task_item.dart';

/// Main screen — displays the task list
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskService _taskService = TaskService();
  late List<TaskModel> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = _taskService.getTasks().toList();
  }

  /// Navigate to AddTaskScreen and refresh list if a task was added
  Future<void> _navigateToAddTask() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );

    if (result != null && result.isNotEmpty) {
      _taskService.addTask(result);
      setState(() {
        _tasks = _taskService.getTasks().toList();
      });
    }
  }

  /// Toggle a task's completion status
  void _toggleTask(String id) {
    _taskService.toggleTask(id);
    setState(() {
      _tasks = _taskService.getTasks().toList();
    });
  }

  /// Count completed tasks for the summary header
  int get _completedCount => _tasks.where((t) => t.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FF),
      appBar: AppBar(
        title: const Text(
          'To Do List',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22,
            color: Color(0xFF2D2D2D),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFEEEEEE), height: 1),
        ),
      ),
      body: Column(
        children: [
          /// Summary card at the top
          _buildSummaryCard(),

          /// Task list
          Expanded(
            child: _tasks.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 100),
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        task: _tasks[index],
                        onToggle: () => _toggleTask(_tasks[index].id),
                      );
                    },
                  ),
          ),
        ],
      ),

      /// FAB to navigate to Add Task screen
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddTask,
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Task',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  /// Summary banner showing task progress
  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF9C95FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.task_alt_rounded, color: Colors.white, size: 32),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_completedCount of ${_tasks.length} tasks completed',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _tasks.isEmpty
                    ? 'No tasks yet'
                    : _completedCount == _tasks.length
                    ? 'All done! 🎉'
                    : '${_tasks.length - _completedCount} remaining',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Shown when there are no tasks
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_rounded, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap "Add Task" to get started',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
