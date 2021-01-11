class ProfileRequest {
  int branch;
  String city;

  ProfileRequest({
    this.branch,
    this.city,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['city'] = this.city;
    data['branch'] = this.branch;

    return data;
  }
}
