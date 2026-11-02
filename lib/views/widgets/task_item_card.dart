import 'package:flutter/material.dart';
import '../../models/task_model.dart';

class TaskItemCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onEdit;

  const TaskItemCard({
    super.key,
    required this.task,
    required this.onEdit,
  });

  IconData _getIcon(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('flutter')) return Icons.laptop_chromebook;
    if (lower.contains('riverpod')) return Icons.menu_book_outlined;
    if (lower.contains('thuyết trình')) return Icons.co_present_outlined;
    if (lower.contains('báo cáo')) return Icons.article_outlined;
    return Icons.assignment_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getIcon(task.title),
            color: const Color(0xFF2C3E50),
          ),
        ),
        title: Text(
          task.title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 13,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                task.description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.edit_outlined,
            color: Color(0xFF374151),
            size: 20,
          ),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
