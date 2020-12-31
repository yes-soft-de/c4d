import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_authorization/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:c4d/module_authorization/states/auth_states/auth_states.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isCaptain = false;
  bool _autoValidate = false;

  AuthState _currentState;

  bool isUserSignedIn ;
  bool signedInUseIsACaptain ;

  String redirectTo;

  @override
  void initState() {
    super.initState();

    widget._stateManager.stateStream.listen((event) {
      print(event.runtimeType.toString());
      _currentState = event;
      processEvent();
    });

    isUserLoggedIn();
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

//   widget._stateManager.isSignedIn().then((value) {
//     if (value) Navigator.of(context).pushReplacementNamed(redirectTo);
//   });

    return screenUi(     );
  }

  Widget screenUi(){
    final node = FocusScope.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding:false,
      body: SingleChildScrollView(
        child: SafeArea(

          child: Form(
            key: _formKey,
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
                        controller: _nameController,
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
                        controller: _emailController,
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
                        controller: _passwordController,
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
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.only(top: 30),
                    height: 70,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      color:  ProjectColors.THEME_COLOR  ,
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                            setState(() {});
                            widget._stateManager.loginWithoutFirebase(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                              _nameController.text.trim(),
                              isCaptain
                            );

                        }
//                      isCaptain ?
//                      Navigator.pushReplacementNamed(
//                        context,
//                        OrdersRoutes.ORDERS_SCREEN
//                      ):
//                      Navigator.pushReplacement(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => InitAccountScreen()),
//                      )
//                      ;
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
