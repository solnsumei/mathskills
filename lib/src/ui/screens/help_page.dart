import 'package:flutter/material.dart';
import '../../core/core.dart';

class HelpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to Play"),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        itemCount: INSTRUCTIONS.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("Step ${index + 1}"),
            subtitle: Text(INSTRUCTIONS[index]),
          );
        },
      ),
    );
  }
}