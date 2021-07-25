
class NotificationIosModel {
  Aps aps;
  String customKey;

  NotificationIosModel({this.aps, this.customKey});

  NotificationIosModel.fromJson(Map<String, dynamic> json) {
    if(json['aps'] is Map)
      this.aps = json["aps"] == null ? null : Aps.fromJson(json["aps"]);
    if(json["customKey"] is String)
      this.customKey = json["customKey"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.aps != null)
      data["aps"] = this.aps.toJson();
    data["customKey"] = this.customKey;
    return data;
  }
}

class Aps {
  Alert alert;
  String badge;

  Aps({this.alert, this.badge});

  Aps.fromJson(Map<String, dynamic> json) {
    if(json["alert"] is Map)
      this.alert = json["alert"] == null ? null : Alert.fromJson(json["alert"]);
    if(json["badge"] is String)
      this.badge = json["badge"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.alert != null)
      data["alert"] = this.alert.toJson();
    data["badge"] = this.badge;
    return data;
  }
}

class Alert {
  String body;
  String title;

  Alert({this.body, this.title});

  Alert.fromJson(Map<String, dynamic> json) {
    if(json["body"] is String)
      this.body = json["body"];
    if(json["title"] is String)
      this.title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["body"] = this.body;
    data["title"] = this.title;
    return data;
  }
}