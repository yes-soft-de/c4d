import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class CaptainLoginWidget extends StatefulWidget {
  final Function(String, String) onLoginRequested;
  // To switch between register and login
  final Function() onAlterRequest;
  final bool isRegister;
  final bool loading;

  CaptainLoginWidget(
      {this.onLoginRequested,
      this.isRegister = false,
      this.onAlterRequest,
      this.loading});

  @override
  State<StatefulWidget> createState() => _CaptainLoginWidgetState();
}

class _CaptainLoginWidgetState extends State<CaptainLoginWidget> {
  final GlobalKey _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
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
                : SizedBox(),
            Flex(
              direction: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2.0,
                            // has the effect of softening the shadow
                            spreadRadius: 2.0,
                            // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          )
                        ]),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: S.of(context).username,
                          hintText: S.of(context).registerHint
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        // Move focus to next
                        validator: (result) {
                          if (result.isEmpty) {
                            return S.of(context).registerHint;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2.0,
                            // has the effect of softening the shadow
                            spreadRadius: 2.0,
                            // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          )
                        ]),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: S.of(context).password,
                        ),
                        validator: (result) {
                          if (result.length < 6) {
                            return S.of(context).passwordIsTooShort;
                          }
                          return null;
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) =>
                            node.unfocus(), // Submit and hide keyboard
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                  title: Text(
                      S.of(context).iAgreeToTheTermsOfServicePrivacyPolicy),
                  onChanged: (v) {
                    agreed = v;
                    if (mounted) setState(() {});
                  }),
            widget.loading == true
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
                              setState(() {});
                              widget.onLoginRequested(_usernameController.text,
                                  _passwordController.text);
                            },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.isRegister
                              ? S.current.register
                              : S.of(context).login,
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
