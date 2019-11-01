import 'package:flutter/material.dart';
import 'dart:async';

import './pages/todos.dart';
import './pages/loading.dart';
import './entities/todo.dart';
import './resources/todo.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  final List<Todo> todos = [];
  final TodoResource resource = TodoResource();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  initialize() async {
    await resource.open();

    final List<Todo> results = await resource.fetch();

    setState(() {
      todos.addAll(results);
      isLoading = false;
    });
  }

  Future<void> add(Todo todo) async {
    await resource.add(todo);

    setState(() => todos.add(todo));
  }

  Future<void> remove(int id) async {
    await resource.remove(id);

    setState(() => todos.removeWhere((todo) => todo.id == id));
  }

  Future<void> activate(Todo todo) async {
    todo.status = "active";

    await resource.update(todo);

    setState(() => todo);
  }

  Future<void> complete(Todo todo) async {
    todo.status = "completed";

    await resource.update(todo);

    setState(() => todo);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.greenAccent, accentColor: Colors.greenAccent),
        home: isLoading
            ? LoadingPage()
            : TodosPage(
                todos: todos,
                onAdd: add,
                onRemove: remove,
                onActivate: activate,
                onComplete: complete,
              ),
      );
}
