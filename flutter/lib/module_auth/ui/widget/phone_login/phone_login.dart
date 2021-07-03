import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class PhoneLoginWidget extends StatefulWidget {
  final Function(String) onLoginRequested;
  final Function() onRetry;
  final Function(String) onConfirm;

  // To switch between register and login
  final Function() onAlterRequest;
  final bool codeSent;
  final bool isRegister;

  PhoneLoginWidget({
    this.onLoginRequested,
    this.onConfirm,
    this.onRetry,
    this.codeSent,
    this.isRegister = false,
    this.onAlterRequest,
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
  String countryCode = '+966';

  bool retryEnabled = false;
  bool agreed = false;
  String hint = '500000000';

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
   if (countryCode == '+966') {
      hint = '500000000';
    } else {
      hint = '700000000';
    }
    return SingleChildScrollView(
      child: Form(
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
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                            labelText: S.of(context).phoneNumber,
                            hintText: '$hint'),
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
            GestureDetector(
              onTap: () {
                if (widget.onAlterRequest != null) widget.onAlterRequest();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(widget.isRegister
                    ? S.of(context).iHaveAnAccount
                    : S.of(context).register),
              ),
            ),
            if (widget.isRegister != false)
              CheckboxListTile(
                  value: agreed,
                  title: Text(S.of(context).iAgreeToTheTermsOfServicePrivacyPolicy),
                  onChanged: (v) {
                    agreed = v;
                    if (mounted) setState(() {});
                  }),
            loading == true
                ? Center(
                    child: Text(S.of(context).loading),
                  )
                : Container(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: widget.isRegister
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).primaryColor,
                      onPressed: !agreed && widget.isRegister
                          ? null
                          : () {
                              String phone = _phoneController.text;
                              if (phone[0] == '0') {
                                phone = phone.substring(1);
                              }
                              loading = true;
                              setState(() {});
                              widget.onLoginRequested(countryCode + phone);
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
      ),
    );
  }
}
