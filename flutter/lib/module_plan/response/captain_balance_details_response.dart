class BalanceDetailsResponse {
  String statusCode;
  String msg;
  Data data;

  BalanceDetailsResponse({this.statusCode, this.msg, this.data});

  BalanceDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }
}

class Data {
  int bounceinThisMonth;
  int kilometerBonusInThisMonth;
  int netProfitInThisMonth;
  var sumPaymentsInThisMonth;
  int totalInThisMonth;
  int countOrdersDeliverd;
  List<Payments> paymentsInThisMonth;
  Data(
      {this.bounceinThisMonth,
      this.countOrdersDeliverd,
      this.kilometerBonusInThisMonth,
      this.netProfitInThisMonth,
      this.paymentsInThisMonth,
      this.sumPaymentsInThisMonth,
      this.totalInThisMonth});

  Data.fromJson(Map<String, dynamic> json) {
    bounceinThisMonth = json['bounce'];
    kilometerBonusInThisMonth = json['sumPayments'];
    netProfitInThisMonth = json['NetProfitInThisMonth'];
    sumPaymentsInThisMonth = json['sumPaymentsInThisMonth'];
    totalInThisMonth = json['totalInThisMonth'];
    countOrdersDeliverd = json['countOrdersDeliverd'];
    if (json['paymentsInThisMonth'] != null) {
      paymentsInThisMonth = new List<Payments>();
      json['paymentsInThisMonth'].forEach((v) {
        paymentsInThisMonth.add(new Payments.fromJson(v));
      });
    }
  }
}

class Payments {
  int id;
  String captainId;
  int amount;
  Date date;

  Payments({this.id, this.captainId, this.amount, this.date});

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainId = json['captainId'];
    amount = json['amount'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['captainId'] = this.captainId;
    data['amount'] = this.amount;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    return data;
  }
}

class Date {
  Timezone timezone;
  int offset;
  int timestamp;

  Date({this.timezone, this.offset, this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
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
