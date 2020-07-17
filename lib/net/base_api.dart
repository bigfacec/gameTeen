import 'dart:convert';
import 'dart:math';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'api.dart';
import '../common/common.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:encrypt/encrypt.dart' as myEncrypt;
import 'package:flutter/material.dart';
import 'package:pointycastle/asymmetric/api.dart';


final Http http = Http();
Map globalData = {
  'channelCode': globalChannelCode,
  'appId': globalAppId,
};
//    xu: 'http://192.168.188.114:8463',
//    test2:'http://ytech.webok.net:8463',
//    test: 'http://192.168.188.248:8464',
//    out: 'https://bigfun.xiaoxiangwan.com'

  
class Http extends BaseHttp {

  @override
  void init(){



    interceptors
      ..add(ApiInterceptor());
  }
}

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {
  var random32Str;
  @override
  onRequest(RequestOptions options) async {
    if(options.path.indexOf('loanVersion/get') != -1 && options.queryParameters['flag'] == 1
        || options.path.indexOf('/loan/api/loanAdvertUrl/list') != -1
    || options.path.indexOf('app/getChannelConfig') != -1
    ){

    }
    else{
      EasyLoading.show();
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = '*/*';
    options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    options.headers['Connection'] = 'keep-alive';
    if(options.path.indexOf('http') == -1){
      options.baseUrl = 'https://bigfun.xiaoxiangwan.com';
//      options.baseUrl = 'http://192.168.188.108:8463';
//      options.baseUrl = 'http://ytech.webok.net:8463';
    }
    if(options.path.indexOf('/h5/') == -1 && options.path.indexOf('http://gmapi.bigfun.io/') == -1){
      random32Str = random32();
      var aesDate = _loadAes(options.queryParameters,random32Str);
      var rsaDate = _loadRsa(random32Str);
      options.data = {
        'params':aesDate,
        'aos':rsaDate
      };
    }

    print(options.headers['accessToken']);
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}, data: ${options.data}');
    return options;
  }
  _loadAes(data,randomStr){
    final plainText = json.encode(data);
    final key = myEncrypt.Key.fromUtf8(randomStr);
    final iv = myEncrypt.IV.fromLength(0);
    final encrypter = myEncrypt.Encrypter(myEncrypt.AES(key,mode: myEncrypt.AESMode.ecb));

    final encrypted = encrypter.encrypt(plainText,iv: iv);
    return encrypted.base64;
  }
  _loadRsa(randomStr){
    final String keyString = 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCjHfZczWx3pKpUepg9xh70CroHFTlvdz6to6rDl3w0/e1qUZByh/vB7HVD2wQ32bPks/1l2WDvMcmup50qbR145x9FxZJmCeIVNJLH018mLOUcFfH49TjdoVFJIkzjimboNGCCo/mxdiUehuee/3pYpZ3yOS4l1IBAs5f/mHybCwIDAQAB';
    final parser = myEncrypt.RSAKeyParser();

    String publicKeyString = splitStr(keyString);
    RSAPublicKey publicKey = parser.parse(publicKeyString);
    final encrypter = myEncrypt.Encrypter(myEncrypt.RSA(publicKey: publicKey,encoding: RSAEncoding.PKCS1));

    var rsaPasswd = encrypter.encrypt(encodeBase64(randomStr));
    return rsaPasswd.base64;
  }
  encodeBase64(String data){
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }
  splitStr(String str) {
    var begin = '-----BEGIN PUBLIC KEY-----\n';
    var end = '\n-----END PUBLIC KEY-----';
    int splitCount = str.length ~/ 64;
    List<String> strList=List();

    for (int i=0; i<splitCount; i++) {
      strList.add(str.substring(64*i, 64*(i+1)));
    }
    if (str.length%64 != 0) {
      strList.add(str.substring(64*splitCount));
    }

    return begin + strList.join('\n') + end;
  }
  random32(){
    String str = '';
    String alphabet = 'abcdefghijklmnopqrstuvwxyz';
    for (int i = 0; i < 32; i++) {
      str += alphabet[Random().nextInt(26)];
    }
    return str;
  }

  @override
  onResponse(Response response) {
    EasyLoading.dismiss();
    debugPrint('---api-response--->resp----->${response.data}');

    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;

      return http.resolve(response);
    } else {
      if (respData.code == -1001) {
        // 如果cookie过期,需要清除本地存储的登录信息
        // StorageManager.localStorage.deleteItem(UserModel.keyUser);
        throw const UnAuthorizedException(); // 需要登录
      } else {
        throw NotSuccessException.fromRespData(respData);
      }
    }
  }

  @override
  Future onError(DioError err) {
    // TODO: implement onError
    EasyLoading.dismiss();
    return super.onError(err);
  }

}

class ResponseData extends BaseResponseData {
  bool get success => 0 == code;

  ResponseData.fromJson(json) {
    code = json['code'].runtimeType == int?json['code']:int.parse(json['code']);
    message = json['msg'];
    data = json['data'];
  }
}
