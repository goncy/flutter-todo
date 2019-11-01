import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import './entities/todo.dart';

import 'pages/todos.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  final List<Todo> todos = [];
  Future<Database> database;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  initialize() async {
    await initializeDatabase();
    await fetchTodos();
  }

  initializeDatabase() async {
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

  fetchTodos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');

    final List<Todo> results = List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        text: maps[i]['text'],
        status: maps[i]['status'],
      );
    });

    setState(() => todos.addAll(results));
  }

  Future<void> add(Todo todo) async {
    print(todo);

    final Database db = await database;

    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    setState(() => todos.add(todo));
  }

  Future<void> remove(int id) async {
    final db = await database;

    await db.delete(
      'todos',
      where: "id = ?",
      whereArgs: [id],
    );

    setState(() => todos.removeWhere((todo) => todo.id == id));
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.greenAccent, accentColor: Colors.greenAccent),
        home: TodosPage(
          todos: todos,
          onAdd: add,
          onRemove: remove,
        ),
      );
}
