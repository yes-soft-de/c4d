import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReportDialogWidget extends StatelessWidget {
  final _reasonController = TextEditingController();

  ReportDialogWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(S.of(context).createNewReport, style: TextStyle(fontSize: 20),),
          ),
          Expanded(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (reason) {
                    if (reason.isEmpty) {
                      return S.of(context).reasonIsRequired;
                    }
                    return null;
                  },
                  controller: _reasonController,
                  decoration: InputDecoration(
                    hintText: S.of(context).reasonOfTheReport,
                  ),
                  maxLines: 6,
                ),
              ),
            ),
          ),
          RaisedButton(
              child: Text(
                S.of(context).cancel,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          RaisedButton(
              color: Colors.red,
              child: Text(
                S.of(context).save,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if(_reasonController.text.isNotEmpty) {
                  Navigator.of(context).pop(_reasonController.text);
                }else {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(S.of(context).pleaseCompleteTheForm)));
                }
              }),
        ],
      ),
    );
  }
}
