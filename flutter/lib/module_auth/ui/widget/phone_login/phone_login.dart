import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneLoginWidget extends StatefulWidget {
  final Function(String) onLoginRequested;
  final Function() onRetry;
  final Function(String) onConfirm;
  final bool loading;
  final bool codeSent;

  PhoneLoginWidget({
    this.onLoginRequested,
    this.onConfirm,
    this.onRetry,
    this.loading,
    this.codeSent,
  });

  @override
  State<StatefulWidget> createState() => _PhoneLoginWidgetState();
}

class _PhoneLoginWidgetState extends State<PhoneLoginWidget> {
  String _errorMsg;
  Scaffold pageLayout;

  final GlobalKey _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  String countryCode = '+963';

  final GlobalKey _confirmCodeKey = GlobalKey<FormState>();
  final TextEditingController _confirmationController = TextEditingController();
  bool retryEnabled = false;

  @override
  Widget build(BuildContext context) {
    return _getUI();
  }

  Widget _getUI() {
    if (widget.codeSent) {
      Future.delayed(Duration(seconds: 30), () {
        retryEnabled = true;
        setState(() {});
      });
      return _getCodeSetter();
    } else {
      return _getPhoneSetter();
    }
  }

  Widget _getCodeSetter() {
    return Form(
      key: _confirmCodeKey,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? SvgPicture.asset('assets/images/logo.svg')
                  : Container(),
              Text(_phoneController.text.trim()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: _confirmationController,
                decoration: InputDecoration(
                  labelText: S.of(context).confirmCode,
                  hintText: '12345',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v.isEmpty) {
                    return S.of(context).pleaseInputPhoneNumber;
                  }
                  return null;
                }),
          ),
          _errorMsg != null ? Text(_errorMsg) : Container(),
          OutlinedButton(
            onPressed: retryEnabled
                ? () {
                    setState(() {});
                  }
                : null,
            child: Text(S.of(context).resendCode),
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).accentColor),
            child: GestureDetector(
              onTap: () {
                widget.onConfirm(_confirmationController.text);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).confirm,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPhoneSetter() {
    return Form(
      key: _signUpFormKey,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Container(
                      height: 144,
                      child: SvgPicture.asset('assets/images/logo.svg'))
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
            ],
          ),
          _errorMsg != null ? Text(_errorMsg) : Container(),
          Container(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                String phone = _phoneController.text;
                if (phone[0] == '0') {
                  phone = phone.substring(1);
                }
                widget.onLoginRequested(countryCode + _phoneController.text);
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
