import 'dart:convert';

import 'package:c4d/consts/branch.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/util/whatsapp_link_helper.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:latlong/latlong.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:lottie/lottie.dart';

abstract class NewOrderState {
  NewOrderScreenState screenState;

  NewOrderState(this.screenState);

  Widget getUI(BuildContext context);
}

class NewOrderStateInit extends NewOrderState {
  NewOrderStateInit(NewOrderScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class NewOrderStateSuccessState extends NewOrderState {
  final _contactFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String countryCode = '+963';
  NewOrderStateSuccessState(NewOrderScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Lottie.asset('assets/animations/on-way.json')),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _contactFormKey,
            autovalidateMode: AutovalidateMode.always,
            child: Flex(
              direction: Axis.vertical,
              children: [
                TextFormField(
                  controller: _nameController,
                  autofocus: false,
                  validator: (v) {
                    if (v.isEmpty) {
                      return S.of(context).pleaseProvideUsWithTheClientName;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).mohammad,
                    labelText: S.of(context).deliverTo,
                  ),
                ),
                TextFormField(
                  controller: _phoneController,
                  autofocus: false,
                  validator: (v) {
                    if (v.isEmpty) {
                      return S.of(context).pleaseProvideUsTheClientPhoneNumber;
                    }
                    if (v.length < 9) {
                      return S.of(context).phoneNumbertooShort;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).phoneNumber,
                    labelText: S.of(context).recipientPhoneNumber,
                    suffix: Container(
                      height: 30,
                      child: DropdownButton(
                        underline: Container(),
                        onChanged: (v) {
                          countryCode = v;
                          screenState.refresh();
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
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 72,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: FlatButton(
                    padding: EdgeInsets.all(24),
                    onPressed: () {
                      screenState.addNewOrder(null, null);
                    },
                    child: Text(
                      S.of(context).skip,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(24),
                    onPressed: () {
                      if (_contactFormKey.currentState.validate()) {
                        String phone = _phoneController.text;
                        if (phone[0] == '0') {
                          phone = phone.substring(1);
                        }
                        screenState.addNewOrder(
                            _nameController.text, countryCode + phone);
                      } else {
                        screenState
                            .showSnackBar(S.of(context).pleaseCompleteTheForm);
                      }
                    },
                    child: Text(
                      S.of(context).save,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class NewOrderStateBranchesLoaded extends NewOrderState {
  List<Branch> branches;

  final List<String> _paymentMethods = ['online', 'cash'];
  String _selectedPaymentMethod = 'online';
  DateTime orderDate = DateTime.now();
  DateTime dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  Branch activeBranch;
  LatLng destination;
  NewOrderStateBranchesLoaded(
      this.branches, LatLng location, NewOrderScreenState screenState)
      : super(screenState) {
    if (location != null) {
      _toController.text =
          WhatsAppLinkHelper.getMapsLink(location.latitude, location.longitude);
      destination = location;
      ;
    }
  }

  @override
  Widget getUI(context) {
    orderDate ??= DateTime.now();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).newOrder,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey,
                ),
              ),
            ),
            Card(
              color: Color(0xff2A2E43),
              elevation: 4,
              child: Container(
                height: 340,
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getBranchSelector(context),
                    //to
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff454F63),
                      ),
                      child: TextFormField(
                        controller: _toController,
                        autofocus: false,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: S.of(context).to,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              getClipBoardData().then((value) {
                                _toController.text = value;
                                screenState.refresh();
                              });
                            },
                            icon: Icon(
                              Icons.paste,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //payment method
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff454F63),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: S.of(context).paymentMethod,
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: Color(0xff454F63),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          dropdownColor: Color(0xff454F63),
                          value: _selectedPaymentMethod ?? 'cash',
                          items: _paymentMethods
                              .map((String method) => DropdownMenuItem(
                                    value: method.toString(),
                                    child: Text(
                                      method == 'cash'
                                          ? S.of(context).cash
                                          : S.of(context).online,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _selectedPaymentMethod = _paymentMethods.firstWhere(
                                (element) => element.toString() == value);
                            screenState.refresh();
                          },
                        ),
                      ),
                    ),
                    Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff454F63),
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                ).then((value) {
                                  if (value != null) {
                                    dateTime = value;
                                    orderDate = DateTime(
                                      dateTime.year,
                                      dateTime.month,
                                      dateTime.day,
                                      time.hour,
                                      time.minute,
                                    );
                                    screenState.refresh();
                                  }
                                });
                              },
                              child: Container(
                                width: 100,
                                child: Center(
                                    child: Text(
                                  DateFormat('yMMMMd').format(dateTime),
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value == null) {
                                  } else {
                                    time = value;
                                    orderDate = DateTime(
                                      dateTime.year,
                                      dateTime.month,
                                      dateTime.day,
                                      time.hour,
                                      time.minute,
                                    );
                                    screenState.refresh();
                                  }
                                });
                              },
                              child: Container(
                                width: 100,
                                child: Center(
                                    child: Text(
                                  DateFormat.jm().format(orderDate),
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),

            //info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: TextFormField(
                  controller: _infoController,
                  autofocus: false,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 16,
                  ),
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: S.of(context).info,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: EdgeInsets.only(top: 30),
                  height: 70,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.grey[100],
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).cancel,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: EdgeInsets.only(top: 30),
                  height: 70,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (activeBranch == null) {
                        screenState
                            .showSnackBar(S.of(context).pleaseSelectABranch);
                        return;
                      }
                      print(destination);
                      screenState.initNewOrder(
                          activeBranch,
                          _toController.text,
                          _infoController.text.trim(),
                          _selectedPaymentMethod ??
                              _selectedPaymentMethod.trim(),
                          orderDate.toUtc().toIso8601String(),
                          destination);
                    },
                    child: Text(
                      S.of(context).apply,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 72,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getClipBoardData() async {
    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
    return data.text;
  }

  Widget getBranchSelector(BuildContext context) {
    if (branches == null) {
      return Container(
        padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff454F63),
        ),
        child: Text(
          S.of(context).errorLoadingBranches,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      activeBranch = branches[0];
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff454F63),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff454F63),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  fillColor: Color(0xff454F63),
                  focusColor: Color(0xff454F63),
                  hintText:
                      '${branches[0].brancheName}',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                items: branches
                    .map((e) => DropdownMenuItem<Branch>(
                          value: e,
                          child: Text(
                            '${e.brancheName}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  activeBranch = val;
                }),
          ),
        ),
      );
    }
  }
}

class NewOrderStateErrorState extends NewOrderState {
  String errMsg;

  NewOrderStateErrorState(this.errMsg, NewOrderScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errMsg}'),
    );
  }
}
