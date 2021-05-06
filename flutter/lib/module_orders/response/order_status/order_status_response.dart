import 'package:c4d/module_orders/response/orders/orders_response.dart';

class OrderStatusResponse {
  String statusCode;
  String msg;
  OrderDetailsData data;

  OrderStatusResponse({this.statusCode, this.msg, this.data});

  OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null
        ? new OrderDetailsData.fromJson(json['Data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class OrderDetailsData {
  int id;
  String ownerID;
  List<String> source;
  GeoJson destination;
  Date date;
  Date updateDate;
  String note;
  String payment;
  String phone;
  String recipientName;
  String recipientPhone;
  String state;
  FromBranch fromBranch;
  GeoJson location;
  String brancheName;
  String branchCity;
  List<AcceptedOrder> acceptedOrder;
  List<dynamic> record;
  String uuid;

  OrderDetailsData(
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
      this.phone,
      this.fromBranch,
      this.location,
      this.brancheName,
      this.branchCity,
      this.acceptedOrder,
      this.record,
      this.uuid});

  OrderDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerID = json['ownerID'];
    source = json['source'].cast<String>();
    // destination = GeoJson.fromJson(json['destination']);
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    updateDate = json['updateDate'] != null
        ? new Date.fromJson(json['updateDate'])
        : null;
    note = json['note'];
    payment = json['payment'];
    phone = json['phone'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    state = json['state'];
    fromBranch = json['fromBranch'] != null
        ? FromBranch.fromJson(json['fromBranch'])
        : null;
    location = GeoJson.fromJson(json['location']);
    brancheName = json['brancheName'];
    branchCity = json['branchCity'];
    try {
      if (json['acceptedOrder'] != null) {
        if (json['acceptedOrder'] is List) {
          List<Map<String, dynamic>> orders = json['accptedOrder'];
          acceptedOrder = <AcceptedOrder>[];
          orders.forEach((element) {
            acceptedOrder.add(AcceptedOrder.fromJson(element));
          });
        }
      }
    } catch (e) {}
    record = json['record'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['ownerID'] = this.ownerID;
    data['source'] = this.source;
    data['destination'] = this.destination;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    if (this.updateDate != null) {
      data['updateDate'] = this.updateDate.toJson();
    }
    data['note'] = this.note;
    data['payment'] = this.payment;
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['state'] = this.state;
    data['fromBranch'] = this.fromBranch;
    data['location'] = this.location;
    data['brancheName'] = this.brancheName;
    data['branchCity'] = this.branchCity;
    try {
      data['acceptedOrder'] = this.acceptedOrder;
    } catch (e) {}
    data['record'] = this.record;
    data['uuid'] = this.uuid;
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

class AcceptedOrder {
  int id;
  String captainID;
  String state;
  String captainName;
  String car;
  String image;
  Null uuid;
  String phone;

  AcceptedOrder(
      {this.id,
      this.captainID,
      this.state,
      this.captainName,
      this.car,
      this.image,
      this.uuid,
      this.phone});

  AcceptedOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainID = json['captainID'];
    state = json['state'];
    captainName = json['captainName'];
    car = json['car'];
    image = json['image'];
    uuid = json['uuid'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['captainID'] = this.captainID;
    data['state'] = this.state;
    data['captainName'] = this.captainName;
    data['car'] = this.car;
    data['image'] = this.image;
    data['uuid'] = this.uuid;
    data['phone'] = this.phone;
    return data;
  }
}
