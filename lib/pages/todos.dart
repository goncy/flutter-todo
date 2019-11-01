import 'package:flutter/material.dart';

import '../entities/todo.dart';

import './add.dart';

class TodosPage extends StatelessWidget {
  final List<Todo> todos;
  final Function onAdd;
  final Function onRemove;
  final Function onComplete;
  final Function onActivate;

  TodosPage(
      {@required this.todos,
      @required this.onAdd,
      @required this.onRemove,
      @required this.onComplete,
      @required this.onActivate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: this.todos.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, i) => i < this.todos.length
                  ? ListTile(
                      title: Text(
                        this.todos[i].text,
                        style: TextStyle(
                            decoration: this.todos[i].status == "completed"
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          this.todos[i].status == "active"
                              ? IconButton(
                                  icon: Icon(Icons.check),
                                  color: Colors.green,
                                  onPressed: () =>
                                      this.onComplete(this.todos[i]),
                                )
                              : IconButton(
                                  icon: Icon(Icons.undo),
                                  color: Colors.amber,
                                  onPressed: () =>
                                      this.onActivate(this.todos[i]),
                                ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => this.onRemove(this.todos[i].id),
                          )
                        ],
                      ),
                    )
                  : null)
          : Center(
              child: Text('There is nothing to do'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPage(onSubmit: this.onAdd)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
