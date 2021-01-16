class OrdersResponse {
  String statusCode;
  String msg;
  List<Order> data;

  OrdersResponse({this.statusCode, this.msg, this.data});

  OrdersResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <Order>[];
      json['Data'].forEach((v) {
        data.add(new Order.fromJson(v));
      });
    }
  }
}

class Order {
  int id;
  String ownerID;
  List<String> source;
  List<String> destination;
  Date date;
  Null updateDate;
  String note;
  String payment;
  String recipientName;
  String recipientPhone;
  String state;
  int fromBranch;
  String location;
  String brancheName;
  String branchCity;
  List<String> acceptedOrder;
  List<Record> record;
  String uuid;

  Order(
      {this.id,
        this.ownerID,
        this.source,
        this.destination,
        this.date,
        this.updateDate,
        this.note,
        this.payment,
        this.recipientName,
        this.recipientPhone,
        this.state,
        this.fromBranch,
        this.location,
        this.brancheName,
        this.branchCity,
        this.acceptedOrder,
        this.record,
        this.uuid});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerID = json['ownerID'];
    if (json['source'] != null) {
      source = new List<Null>();
      json['source'].forEach((v) {
        source.add(v);
      });
    }
    destination = json['destination'].cast<String>();
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    updateDate = json['updateDate'];
    note = json['note'];
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    state = json['state'];
    fromBranch = json['fromBranch'];
    location = json['location'];
    brancheName = json['brancheName'];
    branchCity = json['branchCity'];
    if (json['acceptedOrder'] != null) {
      acceptedOrder = <String>[];
      json['acceptedOrder'].forEach((v) {
        acceptedOrder.add(v);
      });
    }
    if (json['record'] != null) {
      record = <Record>[];
      json['record'].forEach((v) {
        record.add(new Record.fromJson(v));
      });
    }
    uuid = json['uuid'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderID'] = this.orderID;
    data['state'] = this.state;
    if (this.startTime != null) {
      data['startTime'] = this.startTime.toJson();
    }
    return data;
  }
}
