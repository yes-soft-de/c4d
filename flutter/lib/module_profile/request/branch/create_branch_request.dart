class CreateBranchRequest {
  String name;
  Map<String, dynamic> location;

  CreateBranchRequest(
    this.name,
    this.location,
  );

  Map<String, dynamic> toJson() {
    return {
      'brancheName': name,
      'location': location,
    };
  }
}
