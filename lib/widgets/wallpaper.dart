import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gamewallpaper/component/styles.dart';
import 'package:gamewallpaper/model/path.dart';
import 'package:gamewallpaper/test/myAppBar.dart';
import 'dart:async';

import 'download.dart';

class WallPaper extends StatefulWidget {
  _WallPaperState createState() => _WallPaperState();
}
class _WallPaperState extends State<WallPaper> {
  int _index = 0;
  bool initDown = false;
  var downObj = HandleDownload();
  SwiperController _controller;
  _startDown(index) async {
    if(!initDown){
      _handleDown();
    }
    downObj.requestDownload(index);
  }

  _handleDown() async {
    downObj.init();
    setState(() {
      initDown = true;
    });
  }
  void loadImg(){
    for(var map in imagesList){
      _preDownSingle(map['link']);
    }
  }

  Future<void> _preDownSingle(path) async {
    await DefaultCacheManager().getSingleFile(path);
  }
  @override
  void initState() {
    super.initState();
    _controller = new SwiperController();
    loadImg();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar: MyAppBar(
      title: "Wallpaper",
    ),
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.expand(), //随着子元素扩展
            child:
            imagesList[_index].containsKey('path')?
            Image.asset('assets/wallpaper/1.jpg',fit: BoxFit.cover,):
            CachedNetworkImage(
              imageUrl: imagesList[_index]["link"],
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(42),
                      bottom: ScreenUtil().setHeight(177),
                      left: ScreenUtil().setWidth(15),
                      right: ScreenUtil().setWidth(15),
                    ),
                    child:
                    imagesList[index].containsKey('path')?
                    Image.asset('assets/wallpaper/1.jpg',fit: BoxFit.cover,):
                    CachedNetworkImage(
                      imageUrl: imagesList[index]["link"],
                      fit: BoxFit.fitWidth,
                      width: ScreenUtil().setWidth(600),
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: ScreenUtil().setWidth(100),
                          height: ScreenUtil().setWidth(100),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  );
                },
                itemCount: imagesList.length,
                controller: _controller,
                viewportFraction: 0.9,
                scale: 1,
                loop: false,
                onIndexChanged: (itemIndex) {
                  setState(() {
                    _index = itemIndex;
                  });
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              height: ScreenUtil().setHeight(125),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.file_download,
                              size: ScreenUtil().setWidth(47),
                              color: Color(0xff707070),
                            ),
                            Gaps.vGap(3),
                            Text('Download',style: TextStyle(
                                fontSize: ScreenUtil().setSp(29),
                                color: Color(0xff212121)
                            ),)
                          ],
                        ),
                      ),
                      onTap: () {
                        _startDown(_index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
