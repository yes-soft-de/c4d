
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state/orders/orders.state.dart';
import 'package:c4d/module_orders/state_manager/orders/orders.state_manager.dart';
import 'package:c4d/module_orders/ui/screens/order_status_for_captain/order_status_for_captain_screen.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_card.dart';
import 'package:c4d/utils/error_ui/error_ui.dart';
import 'package:c4d/utils/loading_indicator/loading_indicator.dart';
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
  List<OrderModel> orders =[];
  OrdersState currentState = OrdersInitState();
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

  void processEvent(){
   if(currentState is OrdersFetchingDataSuccessState){
     OrdersFetchingDataSuccessState state = currentState;
     orders = state.data;
     loading = false;
     error = false;
   }
   if(currentState is OrdersFetchingDataErrorState){
     loading = false;
     error = true;
   }
   if (this.mounted) {
     setState(() {});
   }

  }

  @override
  Widget build(BuildContext context) {

    if (currentState is OrdersInitState) {
      widget._stateManager.getNearbyOrders();
      if (this.mounted) {
        setState(() {});
      }
    }

    return error
                ? ErrorUi(onRetry: () {
                      widget._stateManager.getNearbyOrders();
                      loading = true;
                      error = false;
                    })
                : loading
                    ? LoadingIndicatorWidget()
                    : screenUi() ;
  }

  Widget screenUi(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body:
      ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context , int index){
          return Container(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(
                    context,
                    OrdersRoutes.ORDER_STATUS_FOR_CAPTAIN_SCREEN,
                  arguments: orders[index].id
                )
                ;
              },
              child: OrderCard(
                to: orders[index].to,
                from:  orders[index].from,
                time:  orders[index].creationTime,
                index: index,
              ),
            ),
          );
        })
    );
  }
}
