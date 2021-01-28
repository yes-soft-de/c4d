import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReportDialogWidget extends StatelessWidget {
  final Function(String) onReport;
  final _reasonController = TextEditingController();

  ReportDialogWidget(this.onReport);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      child: Column(
        children: [
          Text(S.of(context).createNewReport),
          TextFormField(
            controller: _reasonController,
            decoration: InputDecoration(
              hintText: S.of(context).reasonOfTheReport,
            ),
            maxLines: 4,
          ),
          RaisedButton(onPressed: () {
            Navigator.of(context).pop();
          }),
          RaisedButton(onPressed: () {
            onReport(_reasonController.text);
            Navigator.of(context).pop();
          }),
        ],
      ),
    );
  }
}
