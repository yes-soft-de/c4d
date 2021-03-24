class CreateAppointmentRequest {
  String name;
  String phone;

  CreateAppointmentRequest(this.name, this.phone);

  Map<String, dynamic> toJson() {
    return {
      'userName': name,
      'phone': phone,
    };
  }
}