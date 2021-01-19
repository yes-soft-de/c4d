class OrderDetailsResponse {
  int id;
  String orderID;
  String captainID;
  Date date;
  Null duration;
  List<String> source;
  List<String> destination;
  Date orderDate;
  Date orderUpdateDate;
  String orderNote;
  String payment;
  String state;
  List<Record> record;

  OrderDetailsResponse(
      {this.id,
        this.orderID,
        this.captainID,
        this.date,
        this.duration,
        this.source,
        this.destination,
        this.orderDate,
        this.orderUpdateDate,
        this.orderNote,
        this.payment,
        this.state,
        this.record});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderID = json['orderID'];
    captainID = json['captainID'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    duration = json['duration'];
    // source = json['source'].cast<String>();
    // destination = json['destination'].cast<String>();
    orderDate =
    json['orderDate'] != null ? new Date.fromJson(json['orderDate']) : null;
    orderUpdateDate = json['orderUpdateDate'];
    orderNote = json['orderNote'];
    payment = json['payment'];
    state = json['state'];
    if (json['record'] != null) {
      record = <Record>[];
      json['record'].forEach((v) {
        record.add(new Record.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['orderID'] = this.orderID;
    data['captainID'] = this.captainID;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['duration'] = this.duration;
    data['source'] = this.source;
    data['destination'] = this.destination;
    if (this.orderDate != null) {
      data['orderDate'] = this.orderDate.toJson();
    }
    data['orderUpdateDate'] = this.orderUpdateDate;
    data['orderNote'] = this.orderNote;
    data['payment'] = this.payment;
    data['state'] = this.state;
    if (this.record != null) {
      data['record'] = this.record.map((v) => v.toJson()).toList();
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

class Record {
  int id;
  String orderID;
  String state;
  Date startTime;

  Record({this.id, this.orderID, this.state, this.startTime});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderID = json['orderID'];
    state = json['state'];
    startTime =
    json['startTime'] != null ? new Date.fromJson(json['startTime']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['orderID'] = this.orderID;
    data['state'] = this.state;
    if (this.startTime != null) {
      data['startTime'] = this.startTime.toJson();
    }
    return data;
  }
}
