import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state/orders/orders.state.dart';
import 'package:c4d/module_orders/state_manager/orders/orders.state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_card.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OrdersScreen extends StatefulWidget {
  final OrdersStateManager _stateManager;

  OrdersScreen(
    this._stateManager,
  );

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<OrderModel> orders = [];
  OrdersState currentState = OrdersInitState();
  bool loading = true;
  bool error = false;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      setState(() {
        currentState = event;
        processEvent();
      });
    });
    widget._stateManager.getMyOrders();
  }

  void processEvent() {
    if (currentState is OrdersFetchingDataSuccessState) {
      OrdersFetchingDataSuccessState state = currentState;
      orders = state.data;
      loading = false;
      error = false;
    }
    if (currentState is OrdersFetchingDataErrorState) {
      loading = false;
      error = true;
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentState is OrdersFetchingDataState) {
      return getLoadingScreen();
    } else if (currentState is OrdersFetchingDataSuccessState) {
      return getSuccessUI();
    } else {
      return getErrorScreen();
    }
  }

  Widget getLoadingScreen() {
    return Scaffold(
        body: Center(
      child: GestureDetector(
          onTap: () {
            widget._stateManager.getMyOrders();
          },
          child: CircularProgressIndicator()),
    ));
  }

  Widget getErrorScreen() {
    return Scaffold(
        body: Center(
      child: RaisedButton(
        onPressed: () {
          widget._stateManager.getMyOrders();
        },
        child: Text('Retry'),
      ),
    ));
  }

  Widget getSuccessUI() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                widget._stateManager.getMyOrders();
                return null;
              },
              child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            OrdersRoutes.ORDER_STATUS,
                            arguments: orders[index].id,
                          );
                        },
                        child: OrderCard(
                          to: orders[index].to,
                          from: orders[index].from,
                          time: orders[index].creationTime,
                          index: index,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(OrdersRoutes.NEW_ORDER_SCREEN);
            },
            child: Container(
              color: AppThemeDataService.PrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Create new order',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
