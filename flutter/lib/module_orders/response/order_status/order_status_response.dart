class OrderStatusResponse {
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
  List<AcceptedOrder> acceptedOrder;
  List<Record> record;

  OrderStatusResponse(
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
        this.acceptedOrder,
        this.record});

  OrderStatusResponse.fromJson(Map<String, dynamic> json) {
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
    if (json['acceptedOrder'] != null) {
      acceptedOrder = new List<AcceptedOrder>();
      json['acceptedOrder'].forEach((v) {
        acceptedOrder.add(new AcceptedOrder.fromJson(v));
      });
    }
    if (json['record'] != null) {
      record = new List<Record>();
      json['record'].forEach((v) {
        record.add(new Record.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (this.acceptedOrder != null) {
      data['acceptedOrder'] =
          this.acceptedOrder.map((v) => v.toJson()).toList();
    }
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

class AcceptedOrder {
  int id;
  Date acceptedOrderDate;
  String captainID;
  Date duration;
  String state;
  String captainName;
  String car;
  String image;

  AcceptedOrder(
      {this.id,
        this.acceptedOrderDate,
        this.captainID,
        this.duration,
        this.state,
        this.captainName,
        this.car,
        this.image});

  AcceptedOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acceptedOrderDate = json['acceptedOrderDate'] != null
        ? new Date.fromJson(json['acceptedOrderDate'])
        : null;
    captainID = json['captainID'];
    duration =
    json['duration'] != null ? new Date.fromJson(json['duration']) : null;
    state = json['state'];
    captainName = json['captainName'];
    car = json['car'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.acceptedOrderDate != null) {
      data['acceptedOrderDate'] = this.acceptedOrderDate.toJson();
    }
    data['captainID'] = this.captainID;
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    data['state'] = this.state;
    data['captainName'] = this.captainName;
    data['car'] = this.car;
    data['image'] = this.image;
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
