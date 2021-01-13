import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:latlong/latlong.dart';

abstract class NewOrderState {
  NewOrderScreenState screenState;

  NewOrderState(this.screenState);

  Widget getUI(BuildContext context);
}

class NewOrderStateInit extends NewOrderState {
  final List<String> _paymentMethods = ['online', 'cash', 'credit card'];
  String _selectedPaymentMethod;
  DateTime orderDate = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  NewOrderStateInit(LatLng location, NewOrderScreenState screenState)
      : super(screenState) {
    if (location != null) {
      _toController.text = 'From Whatsapp';
    }
  }

  @override
  Widget getUI(context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'New Order',
                style: TextStyle(fontSize: 30, color: Colors.grey),
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
                                screenState.setState(() {});
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
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff454F63),
                      ),
                      child: DropdownButtonFormField(
                          items: _paymentMethods.map((String place) {
                            return new DropdownMenuItem<String>(
                              value: place.toString(),
                              child: new Text(place),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _selectedPaymentMethod = _paymentMethods.firstWhere(
                                (element) => element.toString() == value);
                            screenState.setState(() {});
                          }),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff454F63),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              minTime: DateTime.now(),
                            ).then((value) {
                              orderDate = value;
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
                          'Default Branch',
                          _toController.text.trim(),
                          _infoController.text.trim(),
                          _selectedPaymentMethod.trim(),
                          'recipent name',
                          'reciepent phone',
                          ' ');
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamed(OrdersRoutes.ORDERS_SCREEN);
    });
    return Center(
      child: Text('Create Order Success'),
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
