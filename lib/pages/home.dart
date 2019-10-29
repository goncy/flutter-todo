// pages/home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  int counter = 0;

  void increment() {
    setState(() {
      this.counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:  new Text("Counter"),
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            //mainAxisAlignment is an argument for Column, Row and other
            // layout widgets. It does what CSS's 'justify-content' does
            mainAxisAlignment: MainAxisAlignment.center,
            // If you recall, Column is a layout widget that
            // expects a List who's data is of type Widget:
            children: <Widget>[
              new Text(
                'You have pushed the button this many times:',
              ),
              new Text(this.counter.toString()),
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: increment,
        child: new Icon(Icons.add),
      ),
    );
  }
}