import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/model/branches/branches_model.dart';
import 'package:c4d/module_init/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_init/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_init/ui/screens/update_branches_screen/update_branches_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

abstract class UpdateBranchState {
  final UpdateBranchScreenState screenState;

  UpdateBranchState(this.screenState);

  Widget getUI(BuildContext context);
}

class UpdateBranchStateLoading extends UpdateBranchState {
  UpdateBranchStateLoading(UpdateBranchScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class UpdateBranchStateError extends UpdateBranchState {
  String errorMsg;

  UpdateBranchStateError(
    this.errorMsg,
    UpdateBranchScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errorMsg}'),
    );
  }
}

class UpdateBranchStateLoaded extends UpdateBranchState {
  UpdateBranchStateLoaded(
    UpdateBranchScreenState screenState,
  ) : super(screenState);
  BranchesModel branchLocation;
  final _mapController = MapController();
  bool flag = true;
  BranchesModel model;
  @override
  Widget getUI(BuildContext context) {
    BranchesModel branchesModel = ModalRoute.of(context).settings.arguments;
    if (flag && branchesModel != null) {
      branchLocation = branchesModel;
      model = branchesModel;
      flag = false;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center:
                    branchLocation?.location ?? LatLng(21.5429423, 39.1690945),
                zoom: 15.0,
                onTap: (newPos) {
                  saveMarker(newPos);
                  screenState.refresh();
                },
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://mt.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: branchLocation == null ? [] : _getMarkers(context),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 182.0, right: 8, left: 8),
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
                      screenState.refresh();
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 175,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 8,
                    ),
                    Container(height: 60, child: _getMarkerCards(context)),
                    Container(
                      height: 55,
                      width: double.maxFinite,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text(S.of(context).saveBranch),
                        onPressed: branchLocation == null
                            ? null
                            : () {
                                if (flag) {
                                  screenState.createBranch(CreateBrancheRequest(
                                      branchName: branchLocation.branchName,
                                      location: branchLocation.location));
                                } else {
                                  screenState.updateBranch(
                                      UpdateBranchesRequest(
                                          branchName: branchLocation.branchName,
                                          location: branchLocation.location,
                                          city: branchLocation.city,
                                          userName: branchLocation.userName,
                                          id: branchLocation.id));
                                }
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _getMarkerCards(BuildContext context) {
    if (branchLocation == null) return SizedBox();
    return Card(
      elevation: 3,
      color: Colors.green,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8),
                child: Text(
                  '${branchLocation.branchName}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            var nameController = TextEditingController();
                            return AlertDialog(
                              title: Text(
                                S.of(context).editBranchName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              content: Container(
                                height: 150,
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
                              ),
                            );
                          }).then((result) {
                        if (result != null) {
                          branchLocation.branchName = result;
                          screenState.refresh();
                        }
                      });
                      screenState.refresh();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      branchLocation = null;
                      screenState.refresh();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _mapController.move(branchLocation.location, 15);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> _getMarkers(BuildContext context) {
    if (branchLocation == null) return null;
    return [
      Marker(
        point: branchLocation.location,
        builder: (ctx) => Container(
          child: Icon(
            Icons.my_location,
            color: Colors.green,
          ),
        ),
      )
    ];
  }

  void saveMarker(LatLng location) {
    branchLocation = model ?? BranchesModel();
    branchLocation.location = location;
    branchLocation.branchName = '1';
  }
}
