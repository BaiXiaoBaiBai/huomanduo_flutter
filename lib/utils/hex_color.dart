import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));


  static final String HMD_White="#FFFFFF";
  static final String HMD_333333="#333333";
  static final String HMD_666666="#666666";
  static final String HMD_999999="#999999";
  static final String HMD_F7F7F7="#F7F7F7";
  static final String HMD_DCDCDC="#DCDCDC";
  static final String HMD_1A70FB="#1A70FB";



}
