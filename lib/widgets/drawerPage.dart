import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamewallpaper/common/common.dart';
import 'package:gamewallpaper/component/styles.dart';
import 'package:gamewallpaper/net/repository.dart';
import 'package:gamewallpaper/utils/eventBus.dart';
import 'package:gamewallpaper/widgets/webviewPage.dart';
import 'package:oktoast/oktoast.dart';


class DrawerPage extends StatefulWidget{
  _DrawerPageState createState() => _DrawerPageState();
}
class _DrawerPageState extends State<DrawerPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      elevation: 3,
      child: Container(
        color: Color(0xfffff7f7f7),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: ScreenUtil().setWidth(300),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(150),
                left: ScreenUtil().setWidth(40)
              ),
              color: Colors.white,
              child: Text('Settings',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(69),
                color: Color(0xffff3333333)
              ),
              ),
            ),
            Gaps.vGap(20),
            H5Widget(name: 'User Agreement',url: 'https://scdoc.xiaoxiangwan.com/gameIntroAgreement.html',),
            Gaps.vGap(20),
            H5Widget(name: 'Privacy Agreement',url: 'https://scdoc.xiaoxiangwan.com/gameIntroPrivacyPolicy.html',),

          ],
        ),
      ),
    );
  }
}

class H5Widget extends StatefulWidget{
  const H5Widget({Key key,this.name,this.url}) : super(key: key);
  final String name;
  final String url;
  _H5WidgetState createState() => _H5WidgetState();


}
class _H5WidgetState extends State<H5Widget>{
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Material(
      color: Colors.white,
      child: ListTile(
        title: Text(
          widget.name,
          style: TextStyle(
              fontWeight: FontWeight.w400,
            fontSize: ScreenUtil().setSp(33)
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebviewPage(
              url: widget.url,
              name: widget.name,
            );
          }));
        },
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
