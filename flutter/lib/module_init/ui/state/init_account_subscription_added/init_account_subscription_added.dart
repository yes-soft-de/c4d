import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class InitAccountSubscriptionAdded extends InitAccountState {
  LatLng branchLocation;

  InitAccountSubscriptionAdded(InitAccountScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: FlutterMap(
          options: MapOptions(
            center: LatLng(51.5, -0.09),
            zoom: 13.0,
            onTap: (newPos) {
              branchLocation = newPos;
            },
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(51.5, -0.09),
                  builder: (ctx) => Container(
                    child: FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
        )),
        RaisedButton(
          child: Text('Save Location as Branch 01'),
          onPressed: branchLocation == null
              ? null
              : () {
                  // TODO Add Branch and Move to Payment
                },
        ),
      ],
    );
  }
}
