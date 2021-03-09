import 'dart:async';

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_navigation/ui/widget/drawer_widget/drawer_widget.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state_manager/owner_orders/owner_orders.state_manager.dart';
import 'package:c4d/module_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';

@provide
class OwnerOrdersScreen extends StatefulWidget {
  final OwnerOrdersStateManager _stateManager;

  OwnerOrdersScreen(
    this._stateManager,
  );

  @override
  OwnerOrdersScreenState createState() => OwnerOrdersScreenState();
}

class OwnerOrdersScreenState extends State<OwnerOrdersScreen> {
  OwnerOrdersListState _currentState;
  ProfileResponseModel _currentProfile;

  StreamSubscription _stateSubscription;
  StreamSubscription _profileSubscription;

  void getMyOrders() {
    widget._stateManager.getMyOrders(this);
  }

  void addOrderViaDeepLink(LatLng location) {
    _currentState = OrdersListStateInit(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context)
          .pushNamed(OrdersRoutes.NEW_ORDER_SCREEN, arguments: location);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentState = OrdersListStateInit(this);

    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });

    _profileSubscription = widget._stateManager.profileStream.listen((event) {
      _currentProfile = event;
      if (mounted) {
        setState(() {});
      }
    });

    widget._stateManager.getProfile();
    widget._stateManager.getMyOrders(this);

    DeepLinksService.checkForGeoLink().then((value) {
      if (value != null) {
        Navigator.of(context).pushNamed(
          OrdersRoutes.NEW_ORDER_SCREEN,
          arguments: value,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).home,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ProfileRoutes.EDIT_ACTIVITY_SCREEN);
              }),
        ],
      ),
      drawer: _currentProfile != null
          ? DrawerWidget(
              username: _currentProfile.name ?? 'user',
              user_image: _currentProfile.image ??
                  'https://orthosera-dental.com/wp-content/uploads/2016/02/user-profile-placeholder.png',
            )
          : DrawerWidget(),
      body: _currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    if (_stateSubscription != null) {
      _stateSubscription.cancel();
    }
    if (_profileSubscription != null) {
      _profileSubscription.cancel();
    }
    super.dispose();
  }
}