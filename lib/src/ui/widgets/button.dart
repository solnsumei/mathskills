import 'package:flutter/material.dart';
import '../../core/providers/game_provider.dart';
import '../constants.dart';


class Button extends StatelessWidget {

  Color getFillColor(GameProvider model) {
    if (model.isAnswerCorrect != null) {
      return model.isAnswerCorrect ? Colors.green : Colors.red;
    }

    if (model.selectedNumbers.isNotEmpty) {
      return Colors.orange;
    }

    return Colors.grey[300];
  }

  Widget getActiveText(GameProvider model) {
    if (model.isAnswerCorrect != null) {
      return Icon(
        model.isAnswerCorrect ? Icons.check_rounded : Icons.close_rounded,
        size: 24.0,
        color: Colors.white,
      );
    }

    return Text("=",
        style: kNumberTextStyle.copyWith(
        color: model.selectedNumbers.isEmpty ? Colors.white : kActiveCardColor,
        fontSize: 28,
      ),
    );
  }

  void checkAndSelectAnswer(BuildContext context, GameProvider model) {
    if (model.isAnswerCorrect != null && model.isAnswerCorrect) {
      model.acceptAnswer();
    } else {
      model.checkAnswer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = GameProvider.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            constraints: BoxConstraints.tightFor(
              height: 52.0,
              width: 52.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: getFillColor(model),
            onPressed: model.selectedNumbers.isNotEmpty
                ? () { checkAndSelectAnswer(context, model); }
                : null,
            child: getActiveText(model),
          ),
        ],
      ),
    );
  }
}