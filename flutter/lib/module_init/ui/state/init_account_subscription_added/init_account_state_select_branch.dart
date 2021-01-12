import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class InitAccountStateSelectBranch extends InitAccountState {
  LatLng branchLocation;
  final _mapController = MapController();

  InitAccountStateSelectBranch(InitAccountScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(21.5429423, 39.1690945),
            zoom: 15.0,
            onTap: (newPos) {
              print('New Location' + newPos.toString());
              branchLocation = newPos;
              screen.setState(() {});
            },
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(
              markers: branchLocation == null
                  ? []
                  : [
                      Marker(
                        point: branchLocation,
                        builder: (ctx) => Container(
                          child: Icon(Icons.my_location),
                        ),
                      ),
                    ],
            ),
          ],
        )),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text('Save Location as Branch 01'),
          onPressed: branchLocation == null
              ? null
              : () {
                  screen.saveBranch(branchLocation);
                },
        ),
      ],
    );
  }
}
