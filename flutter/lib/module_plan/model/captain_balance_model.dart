class BalanceModel {
  DateTime nextPaymentDate;
  var currentBalance;
  var bonus;
  var salary;
  List<PaymentModel> payments;
  var nextPay;
  var netProfit;
  var kiloBonus;
  var sumBalance;
  var total;
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
  var amount;

  PaymentModel(this.paymentDate, this.amount);
}
