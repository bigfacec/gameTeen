class VerisonControll {
  String operation;
  String url;

  VerisonControll.fromJsonMap(Map<String, dynamic> map)
      : operation = map["operation"],
        url = map["url"]
  ;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operation'] = operation;
    data['url'] = url;
    return data;
  }
}
