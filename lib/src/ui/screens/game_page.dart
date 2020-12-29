import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';
import '../../core/core.dart';
import 'result_page.dart';

class GamePage extends StatelessWidget {

  getRandomStarList(GameProvider model) {
    return List<Icon>.generate(model.randomStars, (index) =>
        Icon(model.getIconData, color: Colors.deepOrange, size: 58.0));
  }

  void redraw(BuildContext context, GameProvider model) {
    model.redraw();
  }

  void navigateToPage(BuildContext context,
      String widgetName) {

      Navigator.pushNamed(context, widgetName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PLAY NINE"),
        actions: [
          OutlineButton(
            child: Text("How to Play", style: TextStyle(fontSize: 15.0,)),
            onPressed: () {
              navigateToPage(context, "/help");
            },
            borderSide: BorderSide.none,
          ),
          IconButton(
            icon: Icon(Icons.info),
            tooltip: "About",
            onPressed: () {
              navigateToPage(context, "/about");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<GameProvider>(
          builder: (context, model, _) {
            final resultText = model.checkGameStatus();
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                        child: Wrap(
                          spacing: 8.0,
                          children: getRandomStarList(model),
                          alignment: WrapAlignment.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Stack(
                      children: [
                        Positioned(
                          left: 12.0,
                          top: 10.0,
                          child: ActionChip(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            avatar: CircleAvatar(
                              child: Text("${model.counter < 10 ? "0" : ''}${model.counter}"),
                            ),
                            label: Icon(Icons.timer),
                            onPressed: () {

                            },
                          ),
                        ),
                        Button(),
                        Positioned(
                          right: 12.0,
                          top: 10.0,
                          child: ActionChip(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            avatar: CircleAvatar(
                              child: Text("${model.redraws}"),
                            ),
                            onPressed: () {
                              if (model.redraws > 0) {
                                redraw(context, model);
                              }
                            },
                            label: Icon(Icons.cached),
                            tooltip: "Redraw",
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: SelectedItems(
                        selectedItems: model.selectedNumbers,
                        onItemClicked: model.removeSelectedNumber,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      flex: 2,
                      child: NumbersList(
                        numList: model.numList,
                        selectedNumbers: model.selectedNumbers,
                        usedNumbers: model.usedNumbers,
                        onItemPressed: model.selectNumber,
                      ),
                    ),
                  ],
                ),
                !model.isGameOn ||  resultText != null
                    ? Container(
                  child: Card(
                    color: Colors.black87,
                    child: ResultPage(
                      model: model,
                      resultText: resultText,
                      isGameOver: resultText != null,
                    ),
                  ),
                ) : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}

