import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/game_provider.dart';
import '../widgets/widgets.dart';
import 'result_page.dart';

class HomePage extends StatelessWidget {

  getRandomStarList(int number) {
    return List<Icon>.generate(number, (index) =>
        Icon(Icons.wine_bar, color: Colors.purple, size: 58.0));
  }

  Future<void> checkGameStatus(BuildContext context, GameProvider model) async {
    final resultText = model.checkGameStatus();

    if (resultText != null) {
      await Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ResultPage(resultText);
          }
      ));

      model.restart();
    }
  }

  void redraw(BuildContext context, GameProvider model) async {
    model.redraw();
    await checkGameStatus(context, model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PLAY NINE"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            tooltip: "Help",
            onPressed: () {
              Navigator.of(context).pushNamed("/help");
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            tooltip: "About",
            onPressed: () {
              Navigator.of(context).pushNamed("/about");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<GameProvider>(
          builder: (context, model, _) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: getRandomStarList(model.randomStars),
                      alignment: WrapAlignment.center,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Stack(
                  children: [
                    Button(checkGameStatus),
                    Positioned(
                      right: 12.0,
                      top: 12.0,
                      child: ActionChip(
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
            );
          },
        ),
      ),
    );
  }
}