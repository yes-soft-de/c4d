import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/model/branch/branch_model.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class InitAccountStateSelectBranch extends InitAccountState {
  List<BranchModel> branchLocation = [];
  final _mapController = MapController();

  InitAccountStateSelectBranch(InitAccountScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(21.5429423, 39.1690945),
                zoom: 15.0,
                onTap: (newPos) {
                  saveMarker(newPos);
                  screen.refresh();
                },
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: branchLocation == null ? [] : _getMarkers(context),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      Location location = new Location();

                      bool _serviceEnabled = await location.serviceEnabled();
                      if (!_serviceEnabled) {
                        _serviceEnabled = await location.requestService();
                      }

                      var _permissionGranted =
                          await location.requestPermission();
                      if (_permissionGranted == PermissionStatus.denied) {
                        return;
                      }

                      var myLocation = await Location.instance.getLocation();
                      LatLng myPos =
                          LatLng(myLocation.latitude, myLocation.longitude);
                      _mapController.move(myPos, 15);
                      saveMarker(myPos);
                      screen.refresh();
                    },
                  ),
                ),
              ),
            )
          ],
        )),
        Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 96,
              child: ListView(
                children: _getMarkerCards(context),
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text(S.of(context).saveBranches),
              onPressed: branchLocation == null
                  ? null
                  : () {
                      screen.saveBranch(branchLocation);
                    },
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _getMarkerCards(BuildContext context) {
    var branches = <Widget>[];
    for (int i = 0; i < branchLocation.length; i++) {
      branches.add(Card(
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text('${branchLocation[i].name}')),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              var nameController = TextEditingController();
                              return Dialog(
                                child: Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    TextFormField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        hintText: S.of(context).newName,
                                        labelText: S.of(context).newName,
                                      ),
                                      validator: (name) {
                                        if (name.isEmpty) {
                                          return S.of(context).nameIsRequired;
                                        }
                                        return null;
                                      },
                                    ),
                                    RaisedButton(
                                        child: Text(S.of(context).save),
                                        onPressed: () {
                                          if (nameController.text.isNotEmpty) {
                                            Navigator.of(context)
                                                .pop(nameController.text);
                                          }
                                        })
                                  ],
                                ),
                              );
                            }).then((result) {
                          if (result != null) {
                            branchLocation[i].name = result;
                            screen.refresh();
                          }
                        });
                        screen.refresh();
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        branchLocation.remove(branchLocation[i]);
                        screen.refresh();
                      }),
                  IconButton(
                      icon: Icon(Icons.my_location),
                      onPressed: () {
                        _mapController.move(branchLocation[i].location, 15);
                      }),
                ],
              ),
            ),
          ],
        ),
      ));
    }

    return branches;
  }

  List<Marker> _getMarkers(BuildContext context) {
    var markers = <Marker>[];
    branchLocation.forEach((element) {
      markers.add(Marker(
        point: element.location,
        builder: (ctx) => Container(
          child: Icon(
            Icons.my_location,
            color: Colors.black,
          ),
        ),
      ));
    });
    return markers;
  }

  void saveMarker(LatLng location) {
    branchLocation ??= [];
    branchLocation.add(
      BranchModel(location, '${branchLocation.length + 1}'),
    );
  }
}
