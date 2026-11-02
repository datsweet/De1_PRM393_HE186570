import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/database_helper.dart';
import '../models/task_model.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  @override
  Future<List<TaskModel>> build() async {
    return DatabaseHelper.instance.getTasks();
  }

  Future<void> updateTask(TaskModel task) async {
    await DatabaseHelper.instance.updateTask(task);
    ref.invalidateSelf();
  }
}
