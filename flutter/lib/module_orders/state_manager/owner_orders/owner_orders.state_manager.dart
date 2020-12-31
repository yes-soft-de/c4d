
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/service/owner_orders/owner_orders.service.dart';
import 'package:c4d/module_orders/state/owner_orders/owner_orders.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class OwnerOrdersStateManager{
  final OwnerOrdersService _ordersService;
  final PublishSubject<OwnerOrdersState> _stateSubject = PublishSubject();
  Stream<OwnerOrdersState> get stateStream => _stateSubject.stream;


  OwnerOrdersStateManager(
      this._ordersService,
      );

  void getNearbyOrders(){
    _stateSubject.add(OwnerOrdersFetchingDataState());

    _ordersService.getNearbyOrders().then((value) {
      /*if(value == null ){
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
        _stateSubject.add(OwnerOrdersFetchingDataErrorState());
      }*/
//      else{
        _stateSubject.add(OwnerOrdersFetchingDataSuccessState(value));
//      }
    });

  }


}