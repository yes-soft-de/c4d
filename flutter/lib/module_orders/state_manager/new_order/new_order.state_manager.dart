import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/state/new_order/new_order.state.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class NewOrderStateManager {
  final OrdersService _service;
  final ProfileService _profileService;
  final PublishSubject<NewOrderState> _stateSubject = new PublishSubject();

  Stream<NewOrderState> get stateStream => _stateSubject.stream;

  NewOrderStateManager(this._service, this._profileService);

  void loadBranches(NewOrderScreenState screenState, LatLng location) {
    _profileService.getMyBranches().then((value) {
      _stateSubject
          .add(NewOrderStateBranchesLoaded(value, location, screenState));
    });
  }

  void addNewOrder(
      Branch fromBranch,
      String destination,
      String note,
      String paymentMethod,
      String recipientName,
      String recipientPhone,
      String date,
      LatLng destination2,
      NewOrderScreenState screenState) {
    _stateSubject.add(NewOrderStateInit(screenState));
    _service
        .addNewOrder(fromBranch, destination, note, paymentMethod,
            recipientName, recipientPhone, date,destination2)
        .then((newOrder) {
      FirebaseFirestore.instance
          .collection('orders')
          .doc('new_order')
          .collection('order_history')
          .add({'date': DateTime.now().toUtc().toIso8601String()});
      if (newOrder) {
        if (destination.contains('destination')) {
          screenState.goBack();
        } else {
          screenState.moveToNext();
        }
      } else {
        _stateSubject
            .add(NewOrderStateErrorState('Error Creating Order', screenState));
      }
    });
  }
  Future<void> saveLoc(LatLng loc) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('initOrderLocLat',loc.latitude.toString());
    await sharedPreferences.setString('initOrderLocLon',loc.longitude.toString());
  }
  Future<LatLng> getSavedLoc() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double lat = double.parse(sharedPreferences.get('initOrderLocLat') ?? '0');
    double lon = double.parse(sharedPreferences.get('initOrderLocLon') ?? '0');
    if (lat == 0 || lon == 0){
      return null;
    }
    return LatLng(lat, lon);
  }
    Future<void> deleteLoc() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('initOrderLocLat');
    await sharedPreferences.remove('initOrderLocLon');
    }
}
