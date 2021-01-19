import 'package:c4d/consts/branch.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:latlong/latlong.dart';
import 'package:c4d/generated/l10n.dart';

abstract class NewOrderState {
  NewOrderScreenState screenState;

  NewOrderState(this.screenState);

  Widget getUI(BuildContext context);
}

class NewOrderStateInit extends NewOrderState {
  final List<String> _paymentMethods = ['online', 'cash'];
  String _selectedPaymentMethod = 'online';
  DateTime orderDate = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  NewOrderStateInit(LatLng location, NewOrderScreenState screenState)
      : super(screenState) {
    if (location != null) {
      _toController.text = 'From WhatsApp';
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
                height: 300,
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff454F63),
                      ),
                      child: Text(
                        'Default Branch',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    //to
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff454F63),
                      ),
                      child: TextFormField(
                        controller: _toController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'To',
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
                            hintText: 'Payment Method',
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
                                      method,
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff454F63),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            DatePicker.showTimePicker(
                              context,
                            ).then((value) {
                              orderDate = value;
                              screenState.refresh();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                                child: Text(
                                  '${orderDate.hour % 12} : ${orderDate.minute} ${orderDate.hour > 12 ? 'PM' : 'AM'}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )),
                    ),
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Info',
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
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.grey,
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
                      screenState.addNewOrder(
                        BranchName.DefaultBranch,
                        GeoJson(lat: 0, lon: 0),
                        _infoController.text.trim(),
                        _selectedPaymentMethod ?? _selectedPaymentMethod.trim(),
                        null,
                        null,
                        orderDate.toIso8601String(),
                      );
                    },
                    child: Text(
                      'APPLY',
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
}

class NewOrderStateSuccessState extends NewOrderState {
  NewOrderStateSuccessState(NewOrderScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Container(
      height: 600,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/track.png',
            fit: BoxFit.cover,
            height: 300,
            width: 300,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                OrdersRoutes.OWNER_ORDERS_SCREEN,
                (r) => false,
              );
            },
            child: Text(
              S.of(context).orderCreatedReturnToOrders,
            ),
          ),
        ],
      ),
    );
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
