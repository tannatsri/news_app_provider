import 'package:flutter/material.dart';

class BaseTextWidget extends StatelessWidget {
  final BaseTextData? data;

  const BaseTextWidget({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data?.text ?? "",
      style: getBaseTextStyle(data),
      maxLines: data?.maxLine,
      softWrap: false,
      overflow: data?.maxLine != null ? TextOverflow.ellipsis : null,
    );
  }
}

class BaseTextData {
  final String? text;
  final String? font;
  final String? color;
  final int? maxLine;

  BaseTextData({
    this.text,
    this.font,
    this.color,
    this.maxLine,
  });
}

enum BaseTextFontStyle {
  heading(style: "heading", fontWeight: FontWeight.normal, fontSize: 32.0),
  h2(style: "h2", fontWeight: FontWeight.bold, fontSize: 28.0),
  h3(style: "h3", fontWeight: FontWeight.bold, fontSize: 20.0),
  caption(style: "caption", fontWeight: FontWeight.normal, fontSize: 14.0),
  overLine(style: "overline", fontWeight: FontWeight.normal, fontSize: 11.0),
  overLine2(style: "overline2", fontWeight: FontWeight.normal, fontSize: 9.0),
  body(style: "body", fontWeight: FontWeight.normal, fontSize: 16.0);

  static TextStyle textStyle(BaseTextFontStyle style, String? color) {
    return TextStyle(
      fontWeight: style.fontWeight,
      fontSize: style.fontSize,
      color: HexColor(color),
    );
  }

  const BaseTextFontStyle({
    required this.style,
    required this.fontSize,
    required this.fontWeight,
  });

  final String style;
  final FontWeight fontWeight;
  final double fontSize;
}

class HexColor extends Color {
  static int _getColorFromHex(String? hexColor) {
    if (hexColor == null || hexColor == "") {
      return int.parse("FFFFFFFF", radix: 16);
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF${hexColor}";
    }
    try {
      return int.parse(hexColor, radix: 16);
    } catch (e) {
      return int.parse("FFFFFFFF", radix: 16);
    }
  }

  HexColor(final String? hexColor) : super(_getColorFromHex(hexColor));
}

TextStyle getBaseTextStyle(BaseTextData? data) {
  TextStyle textStyle = TextStyle(
    fontFamily: BaseTextFontStyle.body.style,
    fontWeight: BaseTextFontStyle.body.fontWeight,
    fontSize: BaseTextFontStyle.body.fontSize,
    color: HexColor(data?.color),
  );
  if (data != null) {
    var font = data.font;
    switch (font?.toUpperCase()) {
      case "HEADING":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.heading, data.color);
        break;
      case "BODY":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.body, data.color);
      case "CAPTION":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.caption, data.color);
        break;
      case "OVERLINE":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.overLine, data.color);
        break;

      case "OVERLINE2":
        textStyle = BaseTextFontStyle.textStyle(
            BaseTextFontStyle.overLine2, data.color);
        break;
      case "H2":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.h2, data.color);
      case "H3":
        textStyle =
            BaseTextFontStyle.textStyle(BaseTextFontStyle.h3, data.color);
        break;
    }
  }
  return textStyle;
}
