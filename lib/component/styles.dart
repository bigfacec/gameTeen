import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gaps {
  /// 水平间隔
  static Widget hGap(double gap) {
    return SizedBox(width: ScreenUtil().setWidth(gap));
  }

  /// 垂直间隔
  static Widget vGap(double gap) {
    return SizedBox(height: ScreenUtil().setHeight(gap));
  }

  /// 水平划线
  static Widget hGapLine({double gap = 0.6, Color bgColor = Colors.grey}) {
    return Container(
      width: ScreenUtil().setWidth(gap),
      color: bgColor,
    );
  }

  /// 竖直划线
  static Widget vGapLine({double gap = 0.3, Color bgColor = Colors.grey}) {
    return Container(
      height: ScreenUtil().setHeight(gap),
      color: bgColor,
    );
  }

  static Widget line = Container(height: ScreenUtil().setWidth(0.6), color: Colors.grey);
  static const Widget empty = SizedBox();
}
