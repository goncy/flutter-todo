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

  void remove(int index) {
    setState(() => todos.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => TodosPage(
              todos: todos,
              onAdd: add,
              onRemove: remove,
            )
      },
    );
  }
}
