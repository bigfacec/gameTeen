import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamewallpaper/component/styles.dart';
import 'package:gamewallpaper/model/category.dart';
import 'package:gamewallpaper/test/myAppBar.dart';

class DetailPage extends StatefulWidget{
  final int index;
  const DetailPage({Key key, this.index}) : super(key: key);
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{
  int categoryIndex;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
          title: categoryList[categoryIndex]["name"],
      ),
      body:Container(
        color: Color(0xfff7f7f7),
        child: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(33),
                right: ScreenUtil().setWidth(33),
                top: ScreenUtil().setHeight(19),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(24),
                          bottom: ScreenUtil().setHeight(24),
                          left: ScreenUtil().setWidth(29),
                          right: ScreenUtil().setWidth(29),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8),
                              bottom: Radius.circular(
                                  categoryList[categoryIndex]["intro"]["detail"].length>0?0:8
                              ),
                          )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child:
                              Text(categoryList[categoryIndex]["intro"]["simple"],style: TextStyle(
                                  fontSize: ScreenUtil().setSp(33),
                                  height: 1.2,
                                  color: Color(0xff3333333),
                                  fontWeight: FontWeight.w300
                              ),),
                              flex: 1,
                            ),
                          ],
                        ),
                      );
                    }, childCount: 1),

              ),
            ),
            categoryList[categoryIndex]["intro"]["detail"].length > 0?
            SliverPadding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(33),
                right: ScreenUtil().setWidth(33),
                bottom: ScreenUtil().setHeight(19),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(index == categoryList[categoryIndex]["intro"]["detail"].length-1?8:0))
                  ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(29),
                      vertical: ScreenUtil().setHeight(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Gaps.vGap(10),
                        Text(categoryList[categoryIndex]["intro"]["detail"][index]["title"],style: TextStyle(
                            fontSize: ScreenUtil().setSp(38),
                            color: Color(0xff333333)
                        ),),
                        Gaps.vGap(30),
                        Text(categoryList[categoryIndex]["intro"]["detail"][index]["text"],style: TextStyle(
                            fontSize: ScreenUtil().setSp(33),
                            color: Color(0xff333333),
                            fontWeight: FontWeight.w300,
                        ),),
                      ],
                    ),
                  );
                },childCount: categoryList[categoryIndex]["intro"]["detail"].length),
              ),
            ):
            SliverPadding(
              padding: EdgeInsets.all(0),
            )
          ],
        ),
      )
    );
  }
}
