import 'package:flutter/material.dart';
import 'dart:async';

import './pages/todos.dart';
import './pages/loading.dart';
import './entities/todo.dart';
import './resources/todo.dart';

void main() async {
  final TodoResource resource = TodoResource();

  WidgetsFlutterBinding.ensureInitialized();

  await resource.open();

  runApp(App(resource: resource));
}

class App extends StatefulWidget {
  final TodoResource resource;

  App({@required this.resource});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  final List<Todo> todos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetch();
  }

  fetch() async {
    final List<Todo> results = await widget.resource.fetch();

    setState(() {
      todos.addAll(results);
      isLoading = false;
    });
  }

  Future<void> add(Todo todo) async {
    await widget.resource.add(todo);

    setState(() => todos.add(todo));
  }

  Future<void> remove(int id) async {
    await widget.resource.remove(id);

    setState(() => todos.removeWhere((todo) => todo.id == id));
  }

  Future<void> activate(Todo todo) async {
    todo.status = "active";

    await widget.resource.update(todo);

    setState(() => todo);
  }

  Future<void> complete(Todo todo) async {
    todo.status = "completed";

    await widget.resource.update(todo);

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
