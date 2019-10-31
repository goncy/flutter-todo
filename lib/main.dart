import 'package:flutter/material.dart';

import 'pages/todos.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  final List<String> todos = [];

  void add(String todo) {
    setState(() => todos.add(todo));
  }

  void remove(String todo) {
    setState(() => todos.remove(todo));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      routes: {'/': (context) => TodosPage(todos: todos, onAdd: add)},
    );
  }
}
