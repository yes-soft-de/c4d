import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:c4d/module_auth/states/auth_states/auth_states.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class RegisterScreen extends StatefulWidget {
  final AuthStateManager _stateManager;

  RegisterScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _registerNameController = TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();

  AuthState _currentState = AuthStateInit();
  bool loading = false;
  String redirectTo;
  USER_TYPE userType = USER_TYPE.ROLE_CAPTAIN;

  @override
  void initState() {
    super.initState();

    widget._stateManager.stateStream.listen((event) {
      loading = false;
      if (this.mounted) {
        setState(() {
          _currentState = event;
        });
      }
      processEvent();
    });
  }

  void processEvent() {
    if (_currentState is AuthStateAuthSuccess) {
      redirectTo = OrdersRoutes.ORDERS_SCREEN;
      Navigator.of(context).pushReplacementNamed(redirectTo);
    }
    if (_currentState is AuthStateNotRegisteredOwner) {
      redirectTo = OrdersRoutes.ORDERS_SCREEN;
      Navigator.of(context).pushReplacementNamed(redirectTo);
    }
  }

  @override
  Widget build(BuildContext context) {
    var type = ModalRoute.of(context).settings.arguments as USER_TYPE;
    return registerUi(type);
  }

  Widget registerUi(USER_TYPE userType) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Form(
          key: _registerFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 96,
                child: _getHeaderRow(),
              ),
              Expanded(
                child: _getForm(),
              ),
              _getErrorMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getErrorMessage() {
    if (_currentState is AuthStateError) {
      AuthStateError x = _currentState;
      return Text(
        x.errorMsg,
        textAlign: TextAlign.center,
        maxLines: 2,
      );
    } else {
      return Container();
    }
  }

  Widget _getForm() {
    final node = FocusScope.of(context);

    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flex(
          direction: Axis.vertical,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.only(top: 30),
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
        loading
            ? Container(
                child: Text(S.of(context).loading),
              )
            : Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {});
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
                          borderRadius: BorderRadius.circular(15)),
                      color: ProjectColors.THEME_COLOR,
                      onPressed: () {
                        if (loading) {
                          return;
                        }
                        if (_registerFormKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          widget._stateManager.registerWithEmailAndPassword(
                            _registerEmailController.text.trim(),
                            _registerPasswordController.text.trim(),
                            _registerNameController.text.trim(),
                            userType == USER_TYPE.ROLE_CAPTAIN
                                ? 'ROLE_CAPTAIN'
                                : 'ROLE_OWNER',
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
    );
  }

  Widget _getHeaderRow() {
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Container(
              width: 300,
              child: AnimatedAlign(
                  duration: Duration(milliseconds: 300),
                  alignment: userType == USER_TYPE.ROLE_CAPTAIN
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ProjectColors.SECONDARY_COLOR,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' '),
                    ), // For Sizing
                  )),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          userType = USER_TYPE.ROLE_CAPTAIN;
                        });
                      },
                      child: Text(
                        S.of(context).captain,
                        style: TextStyle(
                          color: userType == USER_TYPE.ROLE_CAPTAIN
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          userType = USER_TYPE.ROLE_OWNER;
                        });
                      },
                      child: Text(
                        S.of(context).storeOwner,
                        style: TextStyle(
                          color: userType != USER_TYPE.ROLE_CAPTAIN
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
