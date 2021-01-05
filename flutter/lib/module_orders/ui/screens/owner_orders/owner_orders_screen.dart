import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state/owner_orders/owner_orders.state.dart';
import 'package:c4d/module_orders/state_manager/owner_orders/owner_orders.state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OwnerOrdersScreen extends StatefulWidget {
  final OwnerOrdersStateManager _stateManager;

  OwnerOrdersScreen(
    this._stateManager,
  );

  @override
  _OwnerOrdersScreenState createState() => _OwnerOrdersScreenState();
}

class _OwnerOrdersScreenState extends State<OwnerOrdersScreen> {
  List<OrderModel> myOrders = [];
  OwnerOrdersState currentState = OwnerOrdersInitState();
  bool loading = true;
  bool error = false;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is OwnerOrdersFetchingDataSuccessState) {
      OwnerOrdersFetchingDataSuccessState state = currentState;
      myOrders = state.data;
      loading = false;
      error = false;
    }
    if (currentState is OwnerOrdersFetchingDataErrorState) {
      loading = false;
      error = true;
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentState is OwnerOrdersInitState) {
      widget._stateManager.getNearbyOrders();
      if (this.mounted) {
        setState(() {});
      }
    }

    return Text('error');
  }

  Widget screenUi() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: ProjectColors.THEME_COLOR,
          ),
        ),
      ),
      body: myOrders != null
          ? ListView.builder(
              itemCount: myOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        OrdersRoutes.ORDER_STATUS,
                        arguments: myOrders[index].id,
                      );
                    },
                    child: OwnerOrderCard(
                        to: myOrders[index].to,
                        from: myOrders[index].from,
                        time: myOrders[index].creationTime,
                        index: index),
                  ),
                );
              })
          : Container(
              child: Center(
                child: Text('لم تقم بإرسال أي بضائع بعد'),
              ),
            ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, OrdersRoutes.NEW_ORDER_SCREEN);
        },
        child: Container(
          height: 45,
          color: ProjectColors.SECONDARY_COLOR,
          child: Center(
            child: Text(
              'Request New Delivery',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
