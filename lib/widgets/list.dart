import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamewallpaper/component/styles.dart';
import 'package:gamewallpaper/model/category.dart';
import 'package:gamewallpaper/test/myAppBar.dart';
import 'package:gamewallpaper/widgets/wallpaper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail.dart';
import 'drawerPage.dart';

class ListPage extends StatefulWidget{
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            )),
        child: Scaffold(
            backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
            appBar: MyAppBar(
              title: "Teenpatti",
              backgroundColor: Colors.white.withOpacity(0),
              leadingWidget:  Builder(
                builder: (context) => IconButton(
                  icon: new Icon(Icons.menu,color: Color(0xff212121),),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            drawer: DrawerPage(),
            body: Container(
              child: Center(
                child: Wrap(
                    runSpacing: ScreenUtil().setHeight(40),
                    alignment: WrapAlignment.center,
                    children: categoryList.asMap().keys.map((index) =>
                        InkWell(
                          highlightColor: Colors.white,
                          child: Container(
                            width: ScreenUtil().setWidth(230),
                            child: Column(
                              children: <Widget>[
                                Image.asset("assets/images/${categoryList[index]["image"]}",width: ScreenUtil().setWidth(146),),
                                Gaps.vGap(20),
                                Text(categoryList[index]["name"],style: TextStyle(
                                  fontSize: ScreenUtil().setSp(30),
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff212121),
                                ),
                                  softWrap: false,
                                  overflow: TextOverflow.fade,)
                              ],
                            ),
                          ),
                          onTap: (){
                            var _type = categoryList[index]["type"];
                            if(_type == 1){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return DetailPage(index: index,);
                              }));
                            }else if(_type == 2){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return WallPaper();
                              }));
                            }else if(_type == 3){
                                launch("https://www.google.com/search?q=teenpatti");
                            }
                          },
                        )
                    ).toList()
                ),
              ),
            )));

  }
}