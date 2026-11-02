import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        is_completed INTEGER NOT NULL DEFAULT 0
      )
    ''');

    final initialTasks = [
      TaskModel(
        title: 'Làm bài tập Flutter',
        description: 'Hoàn thành trước thứ Sáu',
      ),
      TaskModel(
        title: 'Ôn tập Riverpod',
        description: 'Xem lại bài giảng MVVM',
      ),
      TaskModel(
        title: 'Chuẩn bị bài thuyết trình',
        description: 'Nhóm 4 - Chủ đề Firebase',
      ),
      TaskModel(
        title: 'Viết báo cáo môn học',
        description: 'Nộp trên LMS',
      ),
    ];

    for (final task in initialTasks) {
      await db.insert('tasks', task.toMap());
    }
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks', orderBy: 'id ASC');
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
