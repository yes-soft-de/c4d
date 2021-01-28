import 'package:c4d/module_orders/response/orders/orders_response.dart';

class GetRecordsResponse {
  String statusCode;
  String msg;
  List<ActivityRecord> data;

  GetRecordsResponse({this.statusCode, this.msg, this.data});

  GetRecordsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = new List<ActivityRecord>();
      json['Data'].forEach((v) {
        data.add(new ActivityRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityRecord {
  int id;
  String ownerID;
  Null userName;
  List<Null> source;
  GeoJson destination;
  Date date;
  Date updateDate;
  String note;
  String payment;
  String recipientName;
  String recipientPhone;
  String state;
  int fromBranch;
  Location location;
  String brancheName;
  String branchCity;
  List<Null> acceptedOrder;
  List<Record> record;
  Null uuid;

  ActivityRecord(
      {this.id,
      this.ownerID,
      this.userName,
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

  ActivityRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerID = json['ownerID'];
    userName = json['userName'];
    destination = GeoJson.fromJson(json['destination']);
    date = json['date'];
    updateDate = json['updateDate'];
    note = json['note'];
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    state = json['state'];
    fromBranch = json['fromBranch'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    brancheName = json['brancheName'];
    branchCity = json['branchCity'];
    if (json['record'] != null) {
      record = <Record>[];
      json['record'].forEach((v) {
        record.add(new Record.fromJson(v));
      });
    }
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownerID'] = this.ownerID;
    data['userName'] = this.userName;
    data['destination'] = this.destination;
    data['date'] = this.date;
    data['updateDate'] = this.updateDate;
    data['note'] = this.note;
    data['payment'] = this.payment;
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['state'] = this.state;
    data['fromBranch'] = this.fromBranch;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['brancheName'] = this.brancheName;
    data['branchCity'] = this.branchCity;
    if (this.record != null) {
      data['record'] = this.record.map((v) => v.toJson()).toList();
    }
    data['uuid'] = this.uuid;
    return data;
  }
}

class Location {
  double lat;
  double lon;

  Location({this.lat, this.lon});

  Location.fromJson(Map<String, dynamic> json) {
    try {
      lat = double.parse(json['lat'].toString());
      lon = double.parse(json['lon'].toString());
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Record {
  int id;
  String orderID;
  String state;
  Date date;

  Record({this.id, this.orderID, this.state, this.date});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderID = json['orderID'];
    state = json['state'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderID'] = this.orderID;
    data['state'] = this.state;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    return data;
  }
}

class Date {
  int offset;
  int timestamp;

  Date({this.offset, this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
