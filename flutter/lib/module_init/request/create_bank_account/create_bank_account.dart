class CreateBankAccountRequest {
  String bankName;
  String accountID;

  CreateBankAccountRequest(this.bankName, this.accountID);

  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName,
      'accountID': accountID,
    };
  }
}