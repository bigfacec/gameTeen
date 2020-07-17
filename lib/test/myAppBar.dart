import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum StatusBarStyle {
  /// 黑色
  dark,

  /// 白色
  light
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double contentHeight; //从外部指定高度
  final Color backgroundColor; //设置导航栏背景的颜色
  Widget leadingWidget;
  final Widget trailingWidget;
  final String title;
  final Widget titleWidget;
  final StatusBarStyle barStyle;

  MyAppBar({
    Key key,
    this.leadingWidget,
    this.title : "",
    this.titleWidget,
    this.contentHeight : 100,
    this.backgroundColor : Colors.white,
    this.barStyle: StatusBarStyle.dark,
    this.trailingWidget,
  }) : super(key:key);


  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle _overlayStyle = barStyle == StatusBarStyle.dark
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;
    if (leadingWidget == null && Navigator.of(context).canPop()) {
      leadingWidget = BackButton(
        color: Color(0xFF212121),
        onPressed: () => Navigator.pop(context),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Container(
        color: backgroundColor,
        child: new SafeArea(
          child: new Container(
              height: ScreenUtil().setHeight(contentHeight),
              child: new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: 0,
                    child: new Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: leadingWidget,
                    ),
                  ),
                title == ""?
                new Container(
                  child: titleWidget
                ):
                  new Container(
                    child: new Text(title,
                        style: new TextStyle(
                          fontSize: ScreenUtil().setSp(38),
                          color: Color(0xFF212121),
                        )),
                  ),
                  Positioned(
                    right: 0,
                    child: new Container(
                      padding: const EdgeInsets.only(right: 5),
                      child: trailingWidget,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size(
      ScreenUtil().setWidth(750), 
      ScreenUtil().setHeight(contentHeight));
}

