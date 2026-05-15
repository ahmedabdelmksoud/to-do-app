import 'package:flutter/material.dart';
import 'package:to_doapp/model/task_model.dart';

/// Reusable widget that renders a single task card
class TaskItem extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggle;

  const TaskItem({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

        /// Checkbox to mark task as complete
        leading: GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: task.isCompleted
                  ? const Color(0xFF6C63FF)
                  : Colors.transparent,
              border: Border.all(
                color: task.isCompleted
                    ? const Color(0xFF6C63FF)
                    : const Color(0xFFCBCBCB),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: task.isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
        ),

        /// Task title with strikethrough when completed
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: task.isCompleted
                ? const Color(0xFFAAAAAA)
                : const Color(0xFF2D2D2D),
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        /// Status badge
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: task.isCompleted
                ? const Color(0xFFE8F5E9)
                : const Color(0xFFF3F0FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            task.isCompleted ? 'Done' : 'Pending',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: task.isCompleted
                  ? const Color(0xFF43A047)
                  : const Color(0xFF6C63FF),
            ),
          ),
        ),
      ),
    );
  }
}
