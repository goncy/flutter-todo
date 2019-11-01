import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/todo.dart';

class TodoResource {
  Future<Database> database;

  open() async {
    database = openDatabase(
      // Set the path to the database.
      join(await getDatabasesPath(), 'todos_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, text TEXT, status TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<List<Todo>> fetch() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        text: maps[i]['text'],
        status: maps[i]['status'],
      );
    });
  }

  Future<Todo> add(Todo todo) async {
    final Database db = await database;

    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return todo;
  }

  Future<Todo> update(Todo todo) async {
    final Database db = await database;

    await db.update(
      'todos',
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );

    return todo;
  }

  Future<int> remove(int id) async {
    final db = await database;

    await db.delete(
      'todos',
      where: "id = ?",
      whereArgs: [id],
    );

    return id;
  }
}
