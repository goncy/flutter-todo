import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/todos.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  final List<String> todos = [];

  @override
  void initState() {
    super.initState();

    fetchTodos();
  }

  fetchTodos() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() => todos.addAll(prefs.getStringList('todos')));
  }

  void add(String todo) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      todos.add(todo);
      prefs.setStringList('todos', todos);
    });
  }

  void remove(int index) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      todos.removeAt(index);
      prefs.setStringList('todos', todos);
    });
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
