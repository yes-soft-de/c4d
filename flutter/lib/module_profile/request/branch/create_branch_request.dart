class CreateBranchRequest {
  String name;
  Map<String, String> location;

  CreateBranchRequest(
    this.name,
    this.location,
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
    };
  }
}
