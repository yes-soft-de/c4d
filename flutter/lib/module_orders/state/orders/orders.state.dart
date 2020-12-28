

import 'package:c4d/module_orders/model/order/order_model.dart';

class OrdersState{ }

class OrdersInitState extends OrdersState{}

class OrdersFetchingDataState extends OrdersState{}

class OrdersFetchingDataSuccessState extends OrdersState{
  List<OrderModel> data;

  OrdersFetchingDataSuccessState(
      this.data,
      );
}

class OrdersFetchingDataErrorState extends OrdersState{}