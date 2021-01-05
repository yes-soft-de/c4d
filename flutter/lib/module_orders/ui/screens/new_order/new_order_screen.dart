import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state/new_order/new_order.state.dart';
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:inject/inject.dart';

@provide
class NewOrderScreen extends StatefulWidget {
  final NewOrderStateManager _stateManager;

  NewOrderScreen(this._stateManager,);

  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final List<String> _places = [
    'branch1',
  ];
  final List<String> _paymentMethods = ['online', 'cache', 'credit card'];
  String _selectedFrom;

  String _selectedPaymentMethod;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  TextEditingController _controller2;
  String _valueChanged2 = '';
  String _valueToValidate2 = '';
  String _valueSaved2 = '';

  NewOrderState currentState = NewOrderStateInitState();

  @override
  void initState() {
    super.initState();

    _controller2 = TextEditingController(text: DateTime.now().toString());
    _controller2.text = DateTime.now().toString();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is NewOrderStateSuccessState) {
      Navigator.pushNamed(context, OrdersRoutes.OWNER_ORDERS_SCREEN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return screenUi();
  }

  Widget screenUi() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsetsDirectional.fromSTEB(10, 30, 10, 30),
            child: Column(
              children: [
                Text(
                  'New Order',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black38,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  padding: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: Color(0xff2A2E43),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //from
                          Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.48,
                              margin: EdgeInsets.only(top: 30),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xff454F63),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    hint: _selectedFrom == null
                                        ? Text(
                                      'From',
                                      style:
                                      TextStyle(color: Colors.grey),
                                    )
                                        : Text(
                                      '${_selectedFrom}',
                                      style:
                                      TextStyle(color: Colors.grey),
                                    ),
                                    items: _places.map((String place) {
                                      return new DropdownMenuItem<String>(
                                        value: place.toString(),
                                        child: new Text(place),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedFrom = _places.firstWhere(
                                                (element) =>
                                            element.toString() == value);
                                      });
                                    }),
                              )),

                          Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.2,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xff454F63),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.my_location,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      //to
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.75,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff454F63),
                        ),
                        child: TextFormField(
                          controller: _toController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          decoration: InputDecoration.collapsed(
                            hintText: 'To',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),

                      //payment method
                      Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.75,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff454F63),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                hint: _selectedPaymentMethod == null
                                    ? Text(
                                  'Payment Method',
                                  style: TextStyle(color: Colors.grey),
                                )
                                    : Text(
                                  '$_selectedPaymentMethod',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                items: _paymentMethods.map((String place) {
                                  return new DropdownMenuItem<String>(
                                    value: place.toString(),
                                    child: new Text(place),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPaymentMethod =
                                        _paymentMethods.firstWhere((element) =>
                                        element.toString() == value);
                                  });
                                }),
                          )),

                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(top: 30),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff454F63),
                        ),
                        child: GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                minTime: DateTime.now(),
                              );
                            },
                            child: Icon(Icons.calendar_today)),
                      ),
                    ],
                  ),
                ),

                //info
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        offset: Offset(0.5, 0.5),
                        blurRadius: 3.0,
                        // has the effect of softening the shadow
                        spreadRadius:
                        3.0, // has the effect of extending the shadow
                      )
                    ],
                    color: Colors.white,
                  ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  child: TextFormField(
                    controller: _infoController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    maxLines: 8,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Info',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      margin: EdgeInsets.only(top: 30),
                      height: 70,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.grey[100],
                        onPressed: () {
                          Navigator.pushNamed(
                              context, OrdersRoutes.OWNER_ORDERS_SCREEN);
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      margin: EdgeInsets.only(top: 30),
                      height: 70,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: ProjectColors.THEME_COLOR,
                        onPressed: () {
                          widget._stateManager.addNewOrder(
                              _selectedFrom.trim(),
                              _toController.text.trim(),
                              _infoController.text.trim(),
                              _selectedPaymentMethod.trim(),
                              'recipent name',
                              'reciepent phone',
                              _controller2.text.trim());
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
