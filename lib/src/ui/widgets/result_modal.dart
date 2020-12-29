import 'package:flutter/material.dart';
import '../../core/core.dart';
import '../constants.dart';

class ResultModal extends StatelessWidget {

  final String resultText;
  final GameProvider model;


  ResultModal({
    @required this.model,
    this.resultText,
  });

  TextStyle getTextStyle() {
    if (resultText == null || resultText == WINNING_TEXT) {
      return kGameWonTextStyle;
    }

    return kGameLostTextStyle;
  }

  String getButtonText([bool gamePaused = false]) {
    if (gamePaused) {
      return "Resume";
    }

    if (resultText != null) {
      return "Play again";
    }

    return "Start Game";
  }

  Widget showGameStatusText(GameProvider model) {
    if (model.isGamePaused) {
      return Text("Game Paused",
        style: kGameWonTextStyle,
      );
    }

    if (resultText != null) {
      return Text(resultText,
        style: getTextStyle(),
      );
    }

    return SizedBox();
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
          child: showGameStatusText(model),
        ),
        SizedBox(height: 40.0),
        RaisedButton(
          onPressed: () {
            if (model.isGamePaused) {
              model.resumeGame();
            } else {
              model.startGame();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(getButtonText(model.isGamePaused),
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