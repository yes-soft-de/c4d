class CaptainBalanceModel {
  DateTime nextPaymentDate;
  int currentBalance;
  int bonus;
  int salary;
  List<PaymentModel> payments;

  CaptainBalanceModel({
    this.nextPaymentDate,
    this.currentBalance,
    this.bonus,
    this.salary,
    this.payments,
  });
}

class PaymentModel {
  DateTime paymentDate;
  int amount;

  PaymentModel(this.paymentDate, this.amount);
}
