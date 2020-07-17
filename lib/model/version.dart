class Verison {
  String appUrl;
  String versionName;
  String versionCode;
  String releaseContent;
  int releaseType;

  Verison.fromJsonMap(Map<String, dynamic> map)
      : appUrl = map["appUrl"],
        versionName = map["versionName"],
        releaseContent = map["releaseContent"],
        versionCode = map["versionCode"],
        releaseType = map["releaseType"]

  ;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUrl'] = appUrl;
    data['versionCode'] = versionName;
    data['releaseContent'] = releaseContent;
    data['releaseType'] = releaseType;
    data['versionCode'] = versionCode;
    return data;
  }
}
