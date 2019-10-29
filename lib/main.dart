// main.dart
import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My App',
      routes: {
        '/': (context) => new HomePage()
      },
    );
  }
}