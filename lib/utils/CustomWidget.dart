import 'package:flutter/cupertino.dart';

import 'SizeConfig.dart';

class CustomWidget {
  static TextStyle customTextStyleBold({var fontSize, Color textColor}) {
    return TextStyle(
      fontSize: SizeConfig.safeBlockHorizontal * fontSize,
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle customTextStyle({var fontSize, Color textColor}) {
    return TextStyle(
      fontSize: SizeConfig.safeBlockHorizontal * fontSize,
      color: textColor,
    );
  }

  static Widget customTextBold({var text, var size, Color color}) {
    return Text(
      text,
      style: customTextStyleBold(fontSize: size, textColor: color),
      textAlign: TextAlign.start,
    );
  }

  static Widget customText({var text, var size, Color color}) {
    return Text(
      text,
      style: customTextStyle(fontSize: size, textColor: color),
      textAlign: TextAlign.start,
    );
  }
}
