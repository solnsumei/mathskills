import 'package:flutter/material.dart';
import '../../core/core.dart';
import '../constants.dart';

class ResultPage extends StatelessWidget {

  final String resultText;

  ResultPage(this.resultText);

  TextStyle getTextStyle() {
    if (resultText == WINNING_TEXT) {
      return kGameWonTextStyle;
    }

    return kGameLostTextStyle;
  }

  String getButtonText() {
    if (resultText == WINNING_TEXT) {
      return "Play again";
    }

    return "Try again";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(resultText,
                style: getTextStyle(),
              ),
            ),
            SizedBox(height: 40.0),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(getButtonText(),
                  style: kLabelTextStyle,
                ),
              ),
              color: kActiveCardColor,
              textColor: Colors.white,
              shape: StadiumBorder(),
            )
          ],
        ),
      ),
    );
  }
}