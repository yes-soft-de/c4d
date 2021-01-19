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

class Order {
  int id;
  String ownerID;
  Null userName;
  List<dynamic> source;
  Destination destination;
  Date date;
  Date updateDate;
  String note;
  String payment;
  String recipientName;
  String recipientPhone;
  String state;
  FromBranch fromBranch;
  GeoJson location;
  String brancheName;
  String branchCity;
  dynamic acceptedOrder;
  dynamic record;
  String uuid;

  Order(
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

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerID = json['ownerID'];
    userName = json['userName'];
    if (json['source'] != null) {
      source = <String>[];
      json['source'].forEach((v) {
        source.add(v);
      });
    }
    destination = json['destination'] != null
        ? new Destination.fromJson(json['destination'])
        : null;
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    updateDate = json['updateDate'] != null
        ? new Date.fromJson(json['updateDate'])
        : null;
    note = json['note'];
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    state = json['state'];
    fromBranch = json['fromBranch'] != null
        ? new FromBranch.fromJson(json['fromBranch'])
        : null;
    location = json['location'];
    brancheName = json['brancheName'];
    branchCity = json['branchCity'];
    acceptedOrder = json['acceptedOrder'];
    record = json['record'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['ownerID'] = this.ownerID;
    data['userName'] = this.userName;
    if (this.source != null) {
      data['source'] = this.source.map((v) => v.toJson()).toList();
    }
    if (this.destination != null) {
      data['destination'] = this.destination.toJson();
    }
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
    if (this.fromBranch != null) {
      data['fromBranch'] = this.fromBranch.toJson();
    }
    data['location'] = this.location;
    data['brancheName'] = this.brancheName;
    data['branchCity'] = this.branchCity;
    data['acceptedOrder'] = this.acceptedOrder;
    data['record'] = this.record;
    data['uuid'] = this.uuid;
    return data;
  }
}

class Destination {
  Null lat;
  Null lon;

  Destination({this.lat, this.lon});

  Destination.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Date {
  int timestamp;

  Date({this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class FromBranch {
  int id;
  String ownerID;
  GeoJson location;
  String city;
  String brancheName;

  FromBranch(
      {this.id, this.ownerID, this.location, this.city, this.brancheName});

  FromBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerID = json['ownerID'];
    location = json['location'] != null
        ? GeoJson.fromJson(json['location'])
        : null;
    city = json['city'];
    brancheName = json['brancheName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['ownerID'] = this.ownerID;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['city'] = this.city;
    data['brancheName'] = this.brancheName;
    return data;
  }
}

class GeoJson {
  double lat;
  double lon;

  GeoJson({this.lat, this.lon});

  GeoJson.fromJson(Map<String, dynamic> json) {
    lat = double.tryParse(json['lat'].toString());
    lon = double.tryParse(json['lon'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
