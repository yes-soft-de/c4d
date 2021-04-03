class PaymentListReponse {
  String statusCode;
  String msg;
  PaymentObject data;

  PaymentListReponse({this.statusCode, this.msg, this.data});

  PaymentListReponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? new PaymentObject.fromJson(json['Data']) : null;
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

class PaymentObject {
  int bounce;
  String sumPayments;
  int netProfit;
  int total;
  int currentTotal;
  int countOrdersDeliverd;
  List<Payments> payments;
  dynamic bank;

  PaymentObject(
      {this.bounce,
        this.sumPayments,
        this.netProfit,
        this.total,
        this.currentTotal,
        this.countOrdersDeliverd,
        this.payments,
        this.bank});

  PaymentObject.fromJson(Map<String, dynamic> json) {
    bounce = json['bounce'];
    sumPayments = json['sumPayments'];
    netProfit = json['NetProfit'];
    total = json['total'];
    currentTotal = json['currentTotal'];
    countOrdersDeliverd = json['countOrdersDeliverd'];
    if (json['payments'] != null) {
      payments = new List<Payments>();
      json['payments'].forEach((v) {
        payments.add(new Payments.fromJson(v));
      });
    }
    bank = json['bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bounce'] = this.bounce;
    data['sumPayments'] = this.sumPayments;
    data['NetProfit'] = this.netProfit;
    data['total'] = this.total;
    data['currentTotal'] = this.currentTotal;
    data['countOrdersDeliverd'] = this.countOrdersDeliverd;
    if (this.payments != null) {
      data['payments'] = this.payments.map((v) => v.toJson()).toList();
    }
    data['bank'] = this.bank;
    return data;
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
