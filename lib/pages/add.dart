import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  final Function onSubmit;

  AddPage({@required this.onSubmit});

  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  final form = GlobalKey<FormState>();
  String todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add todo"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Form(
                  autovalidate: true,
                  key: form,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Something to do'),
                    onSaved: (String _todo) => todo = _todo,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  )),
            ),
            SizedBox(
              child: RaisedButton(
                onPressed: () {
                  if (form.currentState.validate()) {
                    form.currentState.save();
                    widget.onSubmit(todo);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add todo'),
              ),
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
