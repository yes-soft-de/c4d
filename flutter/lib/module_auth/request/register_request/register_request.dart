class RegisterRequest {
  String userID;
  String password;
  List<String> roles;

  RegisterRequest({this.userID, this.password, this.roles});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    password = json['password'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['password'] = this.password;
    data['roles'] = this.roles;
    return data;
  }
}
