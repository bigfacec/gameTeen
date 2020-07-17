import 'dart:convert';


import 'package:gamewallpaper/model/version.dart';
import 'package:gamewallpaper/model/versionControll.dart';

import '../common/common.dart';
import 'base_api.dart';

var channelCode = globalChannelCode, appId = globalAppId;

class Repository {
//获取最新版本
  static Future fetchCurrentVersion(flag) async{
    var response = await http.post('/loan/api/loanVersion/get', queryParameters: {
      'channelCode': channelCode,
      'jq_appId': appId,
      "flag":flag
    });
    print(response.data);
    return Verison.fromJsonMap(response.data);
  }

//  版本控制
  static Future fetchVersionControll() async{
    var response = await http.post('http://gmapi.bigfun.io/app/getChannelConfig',queryParameters: {
      'channelCode':channelCode,
    });
    return VerisonControll.fromJsonMap(response.data);

  }
}
