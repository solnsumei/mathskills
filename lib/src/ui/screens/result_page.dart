import 'package:flutter/material.dart';
import '../../core/core.dart';
import '../constants.dart';

class ResultPage extends StatelessWidget {

  final String resultText;
  final bool isGameOver;
  final GameProvider model;

  ResultPage({
    @required this.model,
    this.isGameOver = true,
    this.resultText,
  });

  TextStyle getTextStyle() {
    if (resultText == null || resultText == WINNING_TEXT) {
      return kGameWonTextStyle;
    }

    return kGameLostTextStyle;
  }

  String getButtonText() {
    if (resultText != null) {
      return "Play again";
    }

    return "Start Game";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: resultText != null ? Text(resultText,
            style: getTextStyle(),
          ) : SizedBox(),
        ),
        SizedBox(height: 40.0),
        RaisedButton(
          onPressed: () {
            model.startGame();
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
    );
  }
}