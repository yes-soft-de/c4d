import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/states/auth_states/auth_states.dart';
import 'package:c4d/module_auth/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class LoginScreen extends StatefulWidget {
  final AuthStateManager _stateManager;

  LoginScreen(this._stateManager);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  AuthState _currentState;
  bool loading = false;
  String redirectTo;
  USER_TYPE userType;

  @override
  void initState() {
    super.initState();

    widget._stateManager.stateStream.listen((event) {
      print('Login Status: ' + event.runtimeType.toString());
      _currentState = event;
      // processEvent();
    });
  }

  void processEvent() {
    if (_currentState is AuthStateAuthSuccess) {
      redirectTo = OrdersRoutes.ORDERS_SCREEN;
      Navigator.of(context).pushReplacementNamed(redirectTo);
    }
    if (_currentState is AuthStateNotRegisteredOwner) {
      redirectTo = InitAccountRoutes.INIT_ACCOUNT_SCREEN;
      Navigator.of(context).pushReplacementNamed(redirectTo);
    }

    widget._stateManager.isSignedIn().then((value) {
      if (value == true) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushNamed(context, OrdersRoutes.ORDERS_SCREEN);
        });
      }
    });

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return loginUi();
  }

  Widget loginUi() {
    final node = FocusScope.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _loginFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 115,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: userType == USER_TYPE.CAPTAIN
                              ? ProjectColors.SECONDARY_COLOR
                              : Colors.white,
                          onPressed: () {
                            setState(() {
                              userType = USER_TYPE.CAPTAIN;
                            });
                          },
                          child: Text(
                            S.of(context).captain,
                            style: TextStyle(
                              color: userType == USER_TYPE.CAPTAIN
                                  ? Colors.white
                                  : ProjectColors.SECONDARY_COLOR,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 115,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: userType == USER_TYPE.CAPTAIN
                              ? Colors.white
                              : ProjectColors.SECONDARY_COLOR,
                          onPressed: () {
                            setState(() {
                              userType == USER_TYPE.STORE_OWNER;
                            });
                          },
                          child: Text(
                            S.of(context).storeOwner,
                            style: TextStyle(
                              color: userType == USER_TYPE.CAPTAIN
                                  ? ProjectColors.SECONDARY_COLOR
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.only(top: 30),
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
                        controller: _loginEmailController,
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
                            return 'الرجاء ادخال الإيميل الخاص بك';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.only(top: 30),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AuthorizationRoutes.REGISTER_SCREEN);
                        setState(() {});
                      },
                      child: Text(loading ? 'Loading' : 'Register'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.only(top: 30),
                    height: 70,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: ProjectColors.THEME_COLOR,
                      onPressed: loading
                          ? null
                          : () {
                              if (_loginFormKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                widget._stateManager.signInWithEmailAndPassword(
                                  _loginEmailController.text.trim(),
                                  _loginPasswordController.text.trim(),
                                  userType.toString(),
                                );
                              }
                            },
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
