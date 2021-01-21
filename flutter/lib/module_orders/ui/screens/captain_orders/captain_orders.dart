import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_orders/state_manager/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_loading.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class CaptainOrdersScreen extends StatefulWidget {
  final CaptainOrdersListStateManager _stateManager;

  CaptainOrdersScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => CaptainOrdersScreenState();
}

class CaptainOrdersScreenState extends State<CaptainOrdersScreen> {
  CaptainOrdersListState currentState;

  void getMyOrders() {
    widget._stateManager.getMyOrders(this);
  }

  void requestAuthorization() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AuthorizationRoutes.LOGIN_SCREEN,
        (r) => false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    currentState = CaptainOrdersListStateLoading(this);
    widget._stateManager.getMyOrders(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).orders),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).pushNamed(ProfileRoutes.PROFILE_SCREEN);
              }),
        ],
      ),
      drawer: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SettingRoutes.ROUTE_SETTINGS);
                  },
                  child: Text(
                    'Settings',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Container(),
          ],
        ),
      ),
      body: currentState.getUI(context),
    );
  }
}
