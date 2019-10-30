// main.dart
import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() => runApp(new App());

class App extends StatefulWidget {
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  int count = 0;

  void increment() {
    setState(() {
      this.count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My App',
      routes: {
        '/': (context) => new HomePage(count: count, onIncrement: increment)
      },
    );
  }
}