import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../../viewmodels/theme_viewmodel.dart';
import '../widgets/color_picker_dialog.dart';
import '../widgets/task_item_card.dart';
import 'edit_task_screen.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarColor = ref.watch(themeViewModelProvider);
    final tasksAsync = ref.watch(taskViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Quản lý công việc',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.palette_outlined, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ColorPickerDialog(),
              );
            },
          ),
        ],
      ),
      body: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Lỗi: $err')),
        data: (tasks) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskItemCard(
                task: task,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(task: task),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E3842),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
