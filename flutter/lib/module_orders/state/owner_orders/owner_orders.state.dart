

import 'package:c4d/module_orders/model/order/order_model.dart';

class OwnerOrdersState{ }

class OwnerOrdersInitState extends OwnerOrdersState{}

class OwnerOrdersFetchingDataState extends OwnerOrdersState{}

class OwnerOrdersFetchingDataSuccessState extends OwnerOrdersState{
  List<OrderModel> data;

  OwnerOrdersFetchingDataSuccessState(
      this.data,
      );
}

class OwnerOrdersFetchingDataErrorState extends OwnerOrdersState{}