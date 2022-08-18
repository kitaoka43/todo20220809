import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:todo20220809/model/to_do.dart';

class ToDoRepository {
  late WidgetRef ref;

  setRef(WidgetRef ref){
    this.ref = ref;
  }

  static Database? database;
  static const String tableName = 'todo';

  static Future<void> _createTable(Database db, int version) async {
    await db.execute(
        'create table $tableName(id integer PRIMARY KEY AUTOINCREMENT, title TEXT, is_done INTEGER, created_time TEXT)');
  }

  static Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'todo_app.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  static Future<Database?> setDb() async {
    if (database == null) {
      database = await initDb();
      return database;
    } else {
      return database;
    }
  }

  static Future<int> insertTodo(ToDo todo) async {
    await database!.insert(tableName, {
      'title': todo.title.toString(),
      'is_done': todo.isDone,
      'created_time': DateTime.now().toString()
    });
    final List<Map<String, dynamic>> maps = await database!.query(tableName);
    return maps.last['id'];
  }

  static Future<List<ToDo>> getToDoList() async {
    final List<Map<String, dynamic>> maps = await database!.query(tableName);
    if (maps.isEmpty) {
      return [];
    } else {
      List<ToDo> todoList = List.generate(
          maps.length,
              (index) => ToDo(
            id: maps[index]['id'],
            title: maps[index]['title'],
            isDone: maps[index]['is_done'],
            createdTime: DateTime.parse(maps[index]['created_time']),
          ));
      return todoList;
    }
  }

  static Future<void> updateDate(ToDo todo) async {
    await database!.update(
        tableName,
        {
          'is_done': todo.isDone
        },
        where: 'id = ?',
        whereArgs: [todo.id]);
  }

  static Future<void> deleteDate(ToDo todo) async {
    await database!.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [todo.id]);
  }
}