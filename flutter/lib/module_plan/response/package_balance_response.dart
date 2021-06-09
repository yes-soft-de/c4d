class PackageBalanceResponse {
  String statusCode;
  String msg;
  Data data;

  PackageBalanceResponse({this.statusCode, this.msg, this.data});

  PackageBalanceResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int packageID;
  String packagename;
  int subscriptionID;
  var remainingOrders;
  int countOrdersDelivered;
  String subscriptionstatus;
  SubscriptionStartDate subscriptionStartDate;
  dynamic subscriptionEndDate;
  String packageCarCount;
  String packageOrderCount;
  int countActiveCar;
  Data(
      {this.packageID,
      this.packagename,
      this.subscriptionID,
      this.remainingOrders,
      this.countOrdersDelivered,
      this.subscriptionstatus,
      this.subscriptionStartDate,
      this.subscriptionEndDate,
      this.packageCarCount,
      this.packageOrderCount,
      this.countActiveCar
      });

  Data.fromJson(Map<String, dynamic> json) {
    packageID = json['packageID'];
    packagename = json['packagename'];
    subscriptionID = json['subscriptionID'];
    remainingOrders = json['remainingOrders'];
    countOrdersDelivered = json['countOrdersDelivered'];
    subscriptionstatus = json['subscriptionstatus'];
    subscriptionStartDate = json['subscriptionStartDate'] != null
        ? new SubscriptionStartDate.fromJson(json['subscriptionStartDate'])
        : null;
    subscriptionEndDate = json['subscriptionEndDate'];
    packageCarCount = json['packageCarCount'];
    packageOrderCount = json['packageOrderCount'];
    countActiveCar = json['countActiveCars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageID'] = this.packageID;
    data['packagename'] = this.packagename;
    data['subscriptionID'] = this.subscriptionID;
    data['remainingOrders'] = this.remainingOrders;
    data['countOrdersDelivered'] = this.countOrdersDelivered;
    data['subscriptionstatus'] = this.subscriptionstatus;
    if (this.subscriptionStartDate != null) {
      data['subscriptionStartDate'] = this.subscriptionStartDate.toJson();
    }
    data['subscriptionEndDate'] = this.subscriptionEndDate;
    data['packageCarCount'] = this.packageCarCount;
    data['packageOrderCount'] = this.packageOrderCount;
    return data;
  }
}

class SubscriptionStartDate {
  Timezone timezone;
  int offset;
  int timestamp;

  SubscriptionStartDate({this.timezone, this.offset, this.timestamp});

  SubscriptionStartDate.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timezone != null) {
      data['timezone'] = this.timezone.toJson();
    }
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Timezone {
  String name;
  List<Transitions> transitions;
  Location location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = new List<Transitions>();
      json['transitions'].forEach((v) {
        transitions.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.transitions != null) {
      data['transitions'] = this.transitions.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Transitions {
  int ts;
  String time;
  int offset;
  bool isdst;
  String abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['time'] = this.time;
    data['offset'] = this.offset;
    data['isdst'] = this.isdst;
    data['abbr'] = this.abbr;
    return data;
  }
}

class Location {
  String countryCode;
  int latitude;
  int longitude;
  String comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}
