import 'dart:io';

import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget padding({PaddingData? data}) {
    if (data == null) return this;
    data.left = data.left ?? 0;
    data.right = data.right ?? 0;
    data.top = data.top ?? 0;
    data.bottom = data.bottom ?? 0;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        data.left!.toDouble(),
        data.top!.toDouble(),
        data.right!.toDouble(),
        data.bottom!.toDouble(),
      ),
      child: this,
    );
  }

  /// returns the widget wrapped in safe area depending upon host platform
  Widget get adaptiveSafeArea {
    if (Platform.isAndroid) {
      return this;
    } else {
      return padding(
        data: PaddingData(left: 0, right: 0, bottom: 0, top: 0),
      );
    }
  }


}

class PaddingData {
  int? left;
  int? right;
  int? top;
  int? bottom;

  PaddingData({
    required this.left,
    required this.right,
    required this.bottom,
    required this.top,
  });

  PaddingData copyWith({int? left, int? right, int? top, int? bottom}) =>
      PaddingData(
        left: left ?? this.left,
        right: right ?? this.right,
        top: right ?? this.top,
        bottom: right ?? this.bottom,
      );
}
