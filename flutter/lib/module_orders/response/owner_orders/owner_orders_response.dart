class OwnerOrdersResponse {
  List<Data> data;

  OwnerOrdersResponse({this.data});

  OwnerOrdersResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  List<String> source;
  List<String> destination;
  Date date;
//  Null updateDate;
  String note;
  String payment;
  String recipientName;
  String recipientPhone;
  String state;
//  Null fromBranch;
//  List<Null> acceptedOrder;
//  Null record;

  Data(
      {this.id,
        this.source,
        this.destination,
        this.date,
//        this.updateDate,
        this.note,
        this.payment,
        this.recipientName,
        this.recipientPhone,
        this.state,
//        this.fromBranch,
//        this.acceptedOrder,
//        this.record
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    source = json['source'].cast<String>();
    destination = json['destination'].cast<String>();
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
//    updateDate = json['updateDate'];
    note = json['note'];
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    state = json['state'];
//    fromBranch = json['fromBranch'];
//    if (json['acceptedOrder'] != null) {
//      acceptedOrder = new List<Null>();
//      json['acceptedOrder'].forEach((v) {
//        acceptedOrder.add(new Null.fromJson(v));
//      });
//    }
//    record = json['record'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['source'] = this.source;
    data['destination'] = this.destination;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
//    data['updateDate'] = this.updateDate;
    data['note'] = this.note;
    data['payment'] = this.payment;
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['state'] = this.state;
//    data['fromBranch'] = this.fromBranch;
//    if (this.acceptedOrder != null) {
//      data['acceptedOrder'] =
//          this.acceptedOrder.map((v) => v.toJson()).toList();
//    }
//    data['record'] = this.record;
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
      transitions = <Transitions>[];
      json['transitions'].forEach((v) {
        transitions.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}
