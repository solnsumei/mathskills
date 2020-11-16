import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const kBottomContainerHeight = 70.0;
const kActiveCardColor = const Color(0xFF1D1E33);
const kInactiveCardColor = const Color(0xFF111328);
const kBottomContainerColor = const Color(0xFFEB1555);
const kContainerTextColor = const Color(0xFF8D8E98);

const kLabelTextStyle = TextStyle(
  fontSize: 20.0,
  color: kContainerTextColor,
  fontWeight: FontWeight.w500,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
  color: kActiveCardColor,
  fontWeight: FontWeight.w500,
);

const kNumberTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w900,
);

const kGameWonTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 26.0,
  fontWeight: FontWeight.bold,
);

const kGameLostTextStyle = TextStyle(
  color: kBottomContainerColor,
  fontSize: 26.0,
  fontWeight: FontWeight.bold,
);


double defaultVerticalSpacing(BuildContext context) => MediaQuery.of(context).size.height * 0.01;

double defaultVerticalMargin(BuildContext context) => Theme.of(context).platform == TargetPlatform.iOS
    ? defaultVerticalSpacing(context) * 1.5 : defaultVerticalSpacing(context) * 1.1;

double defaultHorizontalSpacing(BuildContext context) => MediaQuery.of(context).size.width * 0.01;

double defaultHorizontalMargin(BuildContext context) => Theme.of(context).platform == TargetPlatform.iOS
    ? defaultHorizontalSpacing(context) * 1.5 : defaultHorizontalSpacing(context) * 1.1;