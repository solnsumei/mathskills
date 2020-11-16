import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credits"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(),
            Text(
              'PluralSight Math Skills Game React course',
            ),
            SizedBox(height: 10.0,),
            Text('dev.solmei@gmail.com'),
          ],
        ),
      ),
    );
  }
}