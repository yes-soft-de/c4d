import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state/new_order/new_order.state.dart';
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:inject/inject.dart';

@provide
class NewOrderScreen extends StatefulWidget {
  final NewOrderStateManager _stateManager;

  NewOrderScreen(
    this._stateManager,
  );

  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final List<String> _paymentMethods = ['online', 'cash', 'credit card'];
  String _selectedPaymentMethod;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  DateTime orderDate = DateTime.now();

  TextEditingController _controller2;

  NewOrderState currentState = NewOrderStateInitState();

  @override
  void initState() {
    super.initState();

    _controller2 = TextEditingController(text: DateTime.now().toString());
    _controller2.text = DateTime.now().toString();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      setState(() {});
      print('Got Event!');
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is NewOrderStateSuccessState) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).pushNamed(OrdersRoutes.ORDERS_SCREEN);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return screenUi();
  }

  Widget screenUi() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Order',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                                  setState(() {});
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                hint: _selectedPaymentMethod == null
                                    ? Text(
                                        'Payment Method',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    : Text(
                                        '$_selectedPaymentMethod',
                                        style: TextStyle(color: Colors.white),
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
              Card(
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
                        Navigator.of(context)
                            .pushNamed(OrdersRoutes.ORDER_STATUS);
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
                      color: AppThemeDataService.PrimaryColor,
                      onPressed: () {
                        widget._stateManager.addNewOrder(
                            'Default Branch',
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
    );
  }

  Future<String> getClipBoardData() async {
    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
    return data.text;
  }
}
