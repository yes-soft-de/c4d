import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class PhoneLoginWidget extends StatefulWidget {
  final Function(String) onLoginRequested;
  final Function() onRetry;
  final Function(String) onConfirm;
  final bool codeSent;

  PhoneLoginWidget({
    this.onLoginRequested,
    this.onConfirm,
    this.onRetry,
    this.codeSent,
  });

  @override
  State<StatefulWidget> createState() => _PhoneLoginWidgetState();
}

class _PhoneLoginWidgetState extends State<PhoneLoginWidget> {
  String _errorMsg;
  Scaffold pageLayout;
  bool loading = false;

  final GlobalKey _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  String countryCode = '+963';

  bool retryEnabled = false;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      Future.delayed(Duration(seconds: 30)).then((value) {
        loading = false;
        if (mounted) {
          setState(() {});
        }
      });
    }
    return Form(
      key: _signUpFormKey,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Container(
                  height: 144, child: Image.asset('assets/images/track.png'))
              : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DropdownButton(
                  onChanged: (v) {
                    countryCode = v;
                    if (mounted) setState(() {});
                  },
                  value: countryCode,
                  items: [
                    DropdownMenuItem(
                      value: '+966',
                      child: Text(S.of(context).saudiArabia),
                    ),
                    DropdownMenuItem(
                      value: '+961',
                      child: Text(S.of(context).lebanon),
                    ),
                    DropdownMenuItem(
                      value: '+963',
                      child: Text(S.of(context).syria),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          labelText: S.of(context).phoneNumber,
                          hintText: '123 456 789'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return S.of(context).pleaseInputPhoneNumber;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _errorMsg != null ? Text(_errorMsg) : Container(),
          loading == true
              ? Center(
                  child: Text(S.of(context).loading),
                )
              : Container(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      String phone = _phoneController.text;
                      if (phone[0] == '0') {
                        phone = phone.substring(1);
                      }
                      loading = true;
                      setState(() {});
                      widget.onLoginRequested(
                          countryCode + _phoneController.text);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        S.of(context).sendMeCode,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
