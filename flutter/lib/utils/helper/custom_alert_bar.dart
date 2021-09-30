import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFlushBarHelper {
  static Flushbar createSuccess({ @required String title,@required String message,int timeout = 4,Color background,bool top=false}) {
    return Flushbar(
      title:title,
      message: message,
      icon: Icon(
        Icons.info,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundColor:background??Colors.green,
      duration: Duration(seconds: timeout),
      flushbarPosition:top ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    );
  }
  static Flushbar createError({@required String title,@required String message,int timeout = 4}) {
    return Flushbar(
      title:title,
      message: message,
      icon: Icon(
        Icons.info,
        size: 28.0,
        color: Colors.white,
      ),
      duration: Duration(seconds: timeout),
      backgroundColor: Colors.red,
    );
  }
}