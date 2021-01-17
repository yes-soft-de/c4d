import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class EmailPasswordRegisterForm extends StatefulWidget {
  final bool loading;
  final Function(String, String, String) onRegisterRequest;

  EmailPasswordRegisterForm({
    this.loading,
    this.onRegisterRequest,
  });

  @override
  State<StatefulWidget> createState() => _EmailPasswordRegisterFormState();
}

class _EmailPasswordRegisterFormState extends State<EmailPasswordRegisterForm> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _registerNameController = TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();

  bool loading;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Form(
      key: _registerFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
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
                    controller: _registerNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Name',
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    // Move focus to next
                    validator: (result) {
                      if (result.isEmpty) {
                        return 'الرجاء ادخال اسمك';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
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
                    controller: _registerEmailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Email',
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    // Move focus to next
                    validator: (result) {
                      if (result.isEmpty) {
                        return S.of(context).emailAddressIsRequired;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
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
                    controller: _registerPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Password',
                    ),
                    validator: (result) {
                      if (result.length < 5) {
                        return '';
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
            ],
          ),
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    S.of(context).iHaveAnAccount,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_registerFormKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      widget.onRegisterRequest(
                        _registerEmailController.text.trim(),
                        _registerPasswordController.text.trim(),
                        _registerNameController.text.trim(),
                      );
                    }
                  },
                  child: Text(
                    'CONTINUE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
