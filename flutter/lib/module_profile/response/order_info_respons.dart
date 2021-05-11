import 'profile_response.dart';

class OrderInfoRespons {
  int id;
  String ownerID;
  String userName;
  Date date;
  String updateDate;
  String note;
  String payment;
  String recipientName;
  String recipientPhone;
  BranchName fromBranch;
  String branchCity;
  String acceptedOrder;
  String record;
  String completionTime;
  String uuid;
  String countOrdersInMonth;
  String countOrdersInDay;
  Owner owner;
  var kilometer;
  OrderInfoRespons({
    this.id,
    this.ownerID,
    this.userName,
    this.date,
    this.updateDate,
    this.note,
    this.payment,
    this.recipientName,
    this.recipientPhone,
    this.fromBranch,
    this.branchCity,
    this.acceptedOrder,
    this.record,
    this.completionTime,
    this.uuid,
    this.countOrdersInMonth,
    this.countOrdersInDay,
    this.owner,
    this.kilometer
  });

  OrderInfoRespons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerID = json['ownerID'];
    userName = json['userName'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    fromBranch = BranchName.fromJson(json['fromBranch']);
    owner = Owner.fromJson(json['owner']);
    kilometer = json['kilometer'];
  }
}

class Owner {
  String ownerName;
  String ownerPhone;
  Owner({
    this.ownerName,
    this.ownerPhone,
  });

  Owner.fromJson(Map<String, dynamic> map) {
    ownerName = map['userName'];
    ownerPhone = map['phone'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['userName'] = this.ownerName;
    data['phone'] = this.ownerPhone;
    return data;
  }
}

class BranchName {
  String branchName;
  BranchName({
    this.branchName,
  });

  BranchName.fromJson(Map<String, dynamic> map) {
    branchName = map['brancheName'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['brancheName'] = this.branchName;
    return data;
  }
}
