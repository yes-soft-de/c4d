class BalanceModel {
  DateTime nextPaymentDate;
  int currentBalance;
  int bonus;
  int salary;
  List<PaymentModel> payments;
  var nextPay;
  int netProfit;
  int kiloBonus;
  int sumBalance;
  int total;
  bool details;
  BalanceModel(
      {this.nextPaymentDate,
      this.currentBalance,
      this.bonus,
      this.salary,
      this.payments,
      this.nextPay,
      this.netProfit,
      this.kiloBonus,
      this.sumBalance,
      this.total,
      this.details = false
      });
}

class PaymentModel {
  DateTime paymentDate;
  int amount;

  PaymentModel(this.paymentDate, this.amount);
}
