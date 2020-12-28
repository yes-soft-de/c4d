import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders/orders_screen.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool isCaptain = false;

  @override
  Widget build(BuildContext context) {
    return screenUi(

    );
  }

  Widget screenUi(){
    final node = FocusScope.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding:false,
      body: SafeArea(

        child: Form(
          key: _formKey,
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),

                          ),
                        labelText: 'Name',
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(), // Move focus to next
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),

                        ),
                        labelText: 'Email',
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(), // Move focus to next
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Password',
                    ),
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
                      isCaptain ?
                      Navigator.pushReplacementNamed(
                        context,
                        OrdersRoutes.ORDERS_SCREEN 
                      ):
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InitAccountScreen()),
                      )
                      ;
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
    );
  }
}
