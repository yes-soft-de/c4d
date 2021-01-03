import 'dart:ffi';

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_authorization/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:c4d/module_authorization/states/auth_states/auth_states.dart';
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
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _registerNameController = TextEditingController();
  final TextEditingController _registerEmailController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

  bool loginMode = false;

  bool isCaptain = false;
  bool _autoValidate = false;

  AuthState _currentState;

  bool isUserSignedIn = false;
  bool signedInUseIsACaptain   ;

  bool loading = false;

  String redirectTo;

  @override
  void initState() {
    super.initState();

    widget._stateManager.stateStream.listen((event) {
      print(event.runtimeType.toString());
      _currentState = event;
      processEvent();
    });

  }

  Future<void> isUserLoggedIn()async{
     isUserSignedIn = await widget._stateManager.isSignedIn();
     signedInUseIsACaptain = await widget._stateManager.isCaptain();
  }


  void processEvent(){
    if (_currentState is AuthStateCaptainSuccess) {
      redirectTo = OrdersRoutes.ORDERS_SCREEN;
      Navigator.of(context).pushReplacementNamed(redirectTo);
    }
    if (_currentState is AuthStateOwnerSuccess) {
      redirectTo = OrdersRoutes.OWNER_ORDERS_SCREEN;
      Navigator.of(context).pushReplacementNamed(redirectTo);
    }
    if (_currentState is AuthStateNotRegisteredOwner) {
      redirectTo = InitAccountRoutes.INIT_ACCOUNT_SCREEN;
      Navigator.of(context).pushReplacementNamed(redirectTo);
    }

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    isUserLoggedIn().then((value) {
      print('is captain : $signedInUseIsACaptain');
      if(isUserSignedIn){
        if(signedInUseIsACaptain){
          Future((){
            Navigator.pushNamed(
                context,
                OrdersRoutes.ORDERS_SCREEN
            );
          });
        }else{
          Future((){
            Navigator.pushNamed(
                context,
                OrdersRoutes.OWNER_ORDERS_SCREEN
            );
          });
        }
      }
    });



//   widget._stateManager.isSignedIn().then((value) {
//     if (value) Navigator.of(context).pushReplacementNamed(redirectTo);
//   });

    return loginMode ? loginUi() : registerUi();
  }

  Widget registerUi(){
    final node = FocusScope.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding:false,
      body: SingleChildScrollView(
        child: SafeArea(

          child: Form(
            key: _registerFormKey,
            autovalidate: _autoValidate,
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
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: isCaptain? ProjectColors.SECONDARY_COLOR : Colors.white,
                          onPressed: (){
                            setState(() {
                              isCaptain = true;
                            });
                          },
                          child: Text(
                            'Captain',
                            style: TextStyle(
                              color: isCaptain? Colors.white : ProjectColors.SECONDARY_COLOR ,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 115,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: isCaptain? Colors.white : ProjectColors.SECONDARY_COLOR ,
                          onPressed: (){
                            setState(() {
                              isCaptain = false;
                            });
                          },
                          child: Text(
                            'Store',
                            style: TextStyle(
                              color: isCaptain? ProjectColors.SECONDARY_COLOR : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[100],
                          blurRadius: 2.0, // has the effect of softening the shadow
                          spreadRadius: 2.0, // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        )
                      ]
                    ),
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
                        onEditingComplete: () => node.nextFocus(), // Move focus to next
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
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[100],
                            blurRadius: 2.0, // has the effect of softening the shadow
                            spreadRadius: 2.0, // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          )
                        ]
                    ),
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
                        onEditingComplete: () => node.nextFocus(), // Move focus to next
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
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[100],
                            blurRadius: 2.0, // has the effect of softening the shadow
                            spreadRadius: 2.0, // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          )
                        ]
                    ),
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
                          if (result.length <5) {
                            return 'كلمة المرور يجب ان تكون من 5 محارف على الأقل';
                          }
                          return null;
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => node.unfocus(), // Submit and hide keyboard
                    ),
                  ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: GestureDetector(
                      onTap: () {
                        loginMode = true;
                        setState(() {});
                      },
                      child: Text(loading
                          ? S.of(context).loading
                          : S.of(context).iHaveAnAccount),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: 30),
                    height: 70,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      color:  ProjectColors.THEME_COLOR  ,
                      onPressed:loading
                          ?null
                          : (){
                        if (_registerFormKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            widget._stateManager.registerWithoutFirebase(
                              _registerEmailController.text.trim(),
                              _registerPasswordController.text.trim(),
                              _registerNameController.text.trim(),
                              isCaptain
                            );

                        }

                      },
                      child: Text(
                          'CONTINUE',
                        style: TextStyle(
                          color: Colors.white  ,
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

  Widget loginUi(){
    final node = FocusScope.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding:false,
      body: SingleChildScrollView(
        child: SafeArea(

          child: Form(
            key: _loginFormKey,
            autovalidate: _autoValidate,
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
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: isCaptain? ProjectColors.SECONDARY_COLOR : Colors.white,
                          onPressed: (){
                            setState(() {
                              isCaptain = true;
                            });
                          },
                          child: Text(
                            'Captain',
                            style: TextStyle(
                              color: isCaptain? Colors.white : ProjectColors.SECONDARY_COLOR ,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 115,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: isCaptain? Colors.white : ProjectColors.SECONDARY_COLOR ,
                          onPressed: (){
                            setState(() {
                              isCaptain = false;
                            });
                          },
                          child: Text(
                            'Store',
                            style: TextStyle(
                              color: isCaptain? ProjectColors.SECONDARY_COLOR : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[100],
                            blurRadius: 2.0, // has the effect of softening the shadow
                            spreadRadius: 2.0, // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          )
                        ]
                    ),
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
                        onEditingComplete: () => node.nextFocus(), // Move focus to next
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
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[100],
                            blurRadius: 2.0, // has the effect of softening the shadow
                            spreadRadius: 2.0, // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          )
                        ]
                    ),
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
                          if (result.length <5) {
                            return 'كلمة المرور يجب ان تكون من 5 محارف على الأقل';
                          }
                          return null;
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => node.unfocus(), // Submit and hide keyboard
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: GestureDetector(
                      onTap: () {
                        loginMode = false;
                        setState(() {});
                      },
                      child: Text(loading
                          ? S.of(context).loading
                          : 'انشاء حساب جديد'
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: 30),
                    height: 70,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      color:  ProjectColors.THEME_COLOR  ,
                      onPressed:loading
                          ?null
                          : (){
                        if (_loginFormKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          widget._stateManager.loginWithoutFirebase(
                              _loginEmailController.text.trim(),
                              _loginPasswordController.text.trim(),
                              isCaptain
                          );

                        }
//
                      },
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          color: Colors.white  ,
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
