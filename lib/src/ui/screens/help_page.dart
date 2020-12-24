import 'package:flutter/material.dart';
import '../../core/core.dart';

class HelpPage extends StatelessWidget {

  List<Widget> populateList(List items) {
    final List<Widget> itemsWidget = [];

    final listWithImage = [];
    
    items.asMap().forEach((index, value) {
      final widgetItem = ListTile(
        subtitle: Text(value),
      );
      
      switch(index) {
        case 1:
        case 5:
          listWithImage.add(widgetItem);
          break;
        case 2:
        case 7:
          listWithImage.add(
            Image(image: AssetImage(value)),
          );
          break;
        case 3:
        case 8:
          listWithImage.add(widgetItem);
          itemsWidget.add(
            ListTile(
              subtitle: Row(
                children: List<Widget>.from(listWithImage),
              ),
            )
          );
          listWithImage.clear();
          break;
        default:
          itemsWidget.add(widgetItem);
      }
    });
    
    return itemsWidget;
  }

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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          children: [
            ListTile(
              subtitle: Text(INSTRUCTIONS[0]),
            ),
            ListTile(
              subtitle: Row(
                children: [
                  Text(INSTRUCTIONS[1]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Image(image: AssetImage(INSTRUCTIONS[2]), width: 30.0),
                  ),
                  Expanded(child: Text(INSTRUCTIONS[3]), flex: 2,),
                ],
              ),
            ),
            ListTile(
              subtitle: Text(INSTRUCTIONS[4]),
            ),
            ListTile(
              subtitle: Row(
                children: [
                  Text(INSTRUCTIONS[5]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Image(image: AssetImage(INSTRUCTIONS[6]), width: 30.0),
                  ),
                  Expanded(child: Text(INSTRUCTIONS[7]), flex: 2,),
                ],
              ),
            ),
            ListTile(
              subtitle: Text(INSTRUCTIONS[8]),
            ),
            ListTile(
              subtitle: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Image(image: AssetImage(INSTRUCTIONS[9]), width: 50.0),
                  ),
                  Expanded(child: Text(INSTRUCTIONS[10]), flex: 2,),
                ],
              ),
            ),
            ListTile(
              subtitle: Text(INSTRUCTIONS[11]),
            ),
            ListTile(
              subtitle: Text(INSTRUCTIONS[12]),
            ),
            ListTile(
              subtitle: Text(INSTRUCTIONS[13]),
            ),
            ListTile(
              subtitle: Text(INSTRUCTIONS[14]),
            ),
          ],
        ),
      ),
    );
  }
}