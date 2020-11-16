import 'package:flutter/material.dart';
import '../constants.dart';


class RoundedButton extends StatelessWidget {
  final Function onTap;
  final double size;
  final String text;
  final Color color;
  final ShapeBorder shape;
  

  RoundedButton({this.text, this.shape, this.color, this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      shape: shape ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fillColor: color ?? Color(0xFF4C4F5E),
      onPressed: color != null ? null : onTap,
      constraints: BoxConstraints.tightFor(
        height: size ?? 48.0,
        width: size ?? 48.0,
      ),
      child: Text("$text",
        style: kNumberTextStyle,
      ),
    );
  }
}