import 'package:flutter/material.dart';

import './add.dart';

class TodosPage extends StatelessWidget {
  final List<String> todos;
  final Function onAdd;
  final Function onRemove;

  TodosPage(
      {@required this.todos, @required this.onAdd, @required this.onRemove});

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
                      title: Text(this.todos[i]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => this.onRemove(i),
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
