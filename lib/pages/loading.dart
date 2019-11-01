import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
