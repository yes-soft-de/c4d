import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PaymentRow extends StatelessWidget {
  final DateTime paymentDate;
  final int amount;

  PaymentRow(this.paymentDate, this.amount);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.payment),
          title: Text('${amount} ' + S.of(context).saudiRiyal),
          trailing: Text(
            timeago.format(paymentDate,
                locale: Localizations.localeOf(context).languageCode),
          ),
        ),
      ),
    );
  }
}
