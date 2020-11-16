import 'package:flutter/material.dart';
import 'rounded_button.dart';


class SelectedItems extends StatelessWidget {
  final List<int> selectedItems;
  final Function onItemClicked;

  SelectedItems({@required this.selectedItems, @required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: selectedItems.map((item) =>
            RoundedButton(
              text: '$item',
              onTap: () {
                onItemClicked(item);
              },
              shape: CircleBorder(),
            ),
        ).toList(),
      ),
    );
  }
}