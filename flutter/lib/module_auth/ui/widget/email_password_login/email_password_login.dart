import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:flutter/material.dart';

class EmailPasswordForm extends StatefulWidget {
  final Function(String, String) onLoginRequest;
  String email;
  String password;

  EmailPasswordForm({
    this.onLoginRequest,
    this.email,
    this.password,
  });

  @override
  State<StatefulWidget> createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordForm> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    _loginEmailController.text = widget.email;
    _loginPasswordController.text = widget.password;

    return Form(
      key: _loginFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[100],
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
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _loginEmailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          labelText: 'Email',
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        // Move focus to next
                        validator: (result) {
                          if (result.isEmpty) {
                            return 'الرجاء ادخال الإيميل الخاص بك';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[100],
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
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _loginPasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Password',
                        ),
                        validator: (result) {
                          if (result.length < 5) {
                            return 'كلمة المرور يجب ان تكون من 5 محارف على الأقل';
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AuthorizationRoutes.REGISTER_SCREEN);
                    },
                    child: Text(
                      loading == true ? 'Loading' : 'Register',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    color: Theme.of(context).primaryColor,
                    onPressed: loading == true
                        ? null
                        : () {
                            if (_loginFormKey.currentState.validate()) {
                              loading = true;
                              setState(() {});
                              widget.onLoginRequest(
                                _loginEmailController.text,
                                _loginPasswordController.text,
                              );
                            }
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
