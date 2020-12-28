


import 'package:c4d/module_orders/model/order/order_model.dart';

class OrderStatusState{ }

class OrderStatusInitState extends OrderStatusState{}

class OrderStatusFetchingDataState extends OrderStatusState{}

class OrderStatusFetchingDataSuccessState extends OrderStatusState{
   OrderModel  data;

  OrderStatusFetchingDataSuccessState(
      this.data,
      );
}

class OrderStatusFetchingDataErrorState extends OrderStatusState{}