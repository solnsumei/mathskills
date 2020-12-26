import 'package:flutter/material.dart';
import '../constants.dart';
import '../../core/core.dart';
import 'rounded_button.dart';


class NumbersList extends StatelessWidget {
  final List<int> numList;
  final Set<int> selectedNumbers;
  final Set<int> usedNumbers;
  final Function onItemPressed;

  NumbersList({
    @required this.numList,
    @required this.onItemPressed,
    @required this.selectedNumbers,
    @required this.usedNumbers,
  });

  Color getItemColor(int number) {
    if (usedNumbers.contains(number)) {
      return Colors.green[200];
    } else if (selectedNumbers.contains(number)) {
      return Colors.grey[300];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.orange,
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(30.0),
        //   topRight: Radius.circular(30.0),
        // ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(TEXT_CONTENT,
              textAlign: TextAlign.center,
              style: kBodyTextStyle.copyWith(fontSize: 19.0),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 16.0,
                runSpacing: 16.0,
                children: numList.map((item) =>
                    RoundedButton(
                      text: "$item",
                      onTap: () {
                        onItemPressed(item);
                      },
                      size: 50.0,
                      color: getItemColor(item),
                    )
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}