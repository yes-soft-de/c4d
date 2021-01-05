import 'package:c4d/module_init/model/package/packages.model.dart';
import 'package:c4d/module_init/state/init_account/init_account.state.dart';
import 'package:c4d/module_init/state_manager/init_account/init_account.state_manager.dart';
import 'package:c4d/module_init/ui/widget/package_card/package_card.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountScreen extends StatefulWidget {
  final InitAccountStateManager _stateManager;

  InitAccountScreen(
    this._stateManager,
  );

  @override
  _InitAccountScreenState createState() => _InitAccountScreenState();
}

class _InitAccountScreenState extends State<InitAccountScreen> {
  List<PackageModel> _packages = [];
  InitAccountState currentState = InitAccountInitState();
  bool loading = false;
  bool error = false;
  int _selectedPackageId = -1;

  final List<ListItem> _cities = [
    ListItem(1, "daraa"),
    ListItem(2, "homs"),
  ];
  final List<ListItem> _sizes = [
    ListItem(1, "1"),
  ];

  ListItem _selectedCity;
  ListItem _selectedSize;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is InitAccountCreateProfileSuccessState) {
      widget._stateManager.getPackages();
      loading = true;
      error = false;
    }
    if (currentState is InitAccountFetchingDataSuccessState) {
      InitAccountFetchingDataSuccessState state = currentState;
      _packages = state.data;
      loading = false;
      error = false;
    }
    if (currentState is InitAccountSubscribeSuccessState) {
      Navigator.pushReplacementNamed(context, OrdersRoutes.OWNER_ORDERS_SCREEN);
    }

//    if(currentState is InitAccountFetchingDataErrorState){
//      loading = false;
//      error = true;
//    }
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
//    if (currentState is InitAccountInitState) {
//      widget._stateManager.getPackages();
//      if (this.mounted) {
//        setState(() {});
//      }
//    }

    return Text('error');
  }

  Widget screenUi() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: ProjectColors.THEME_COLOR,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
          child: Column(
            children: [
              //city
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 3.0,
                        // has the effect of softening the shadow
                        spreadRadius: 3.0,
                        // has the effect of extending the shadow
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      )
                    ]),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: _selectedCity == null
                              ? Text(
                                  'Choose Your City',
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Text(
                                  '${_selectedCity.name}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                          items: _cities.map((ListItem lang) {
                            return new DropdownMenuItem<String>(
                              value: lang.value.toString(),
                              child: new Text(lang.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCity = _cities.firstWhere((element) =>
                                  element.value.toString() == value);

                              if (_selectedSize != null) {
                                widget._stateManager.createProfile(
                                    _selectedCity.name, _selectedSize.value);
                              }
                            });
                          }),
                    )

//
                    ),
              ),
              //size
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 3.0,
                        // has the effect of softening the shadow
                        spreadRadius: 3.0,
                        // has the effect of extending the shadow
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      )
                    ]),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: _selectedSize == null
                              ? Text(
                                  'Choose Your Size',
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Text(
                                  '${_selectedSize.name}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                          items: _sizes.map((ListItem lang) {
                            return new DropdownMenuItem<String>(
                              value: lang.value.toString(),
                              child: new Text(lang.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedSize = _sizes.firstWhere((element) =>
                                  element.value.toString() == value);
                            });

                            if (_selectedCity != null) {
                              widget._stateManager.createProfile(
                                  _selectedCity.name, _selectedSize.value);
                            }
                          }),
                    )

//
                    ),
              ),
              //package
              (_packages.isNotEmpty)
                  ? Container(
                      height: 275,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _packages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedPackageId = _packages[index].id;
                                });
                              },
                              child: Opacity(
                                opacity:
                                    _selectedPackageId == _packages[index].id
                                        ? 0.5
                                        : 1.0,
                                child: PackageCard(
                                  index: index,
                                  carsNumber: _packages[index].carCount,
                                  ordersNumber: _packages[index].orderCount,
                                  packageNumber: _packages[index].id.toString(),
                                  price: _packages[index].cost,
                                ),
                              ),
                            );
                          }),
                    )
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(top: 20),
                      child: Text('الرجاء قم باختيار مدينة وعدد الأفرع')),

              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(top: 30),
                height: 70,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: ProjectColors.THEME_COLOR,
                  onPressed: (_selectedPackageId == null)
                      ? null
                      : () {
                          setState(() {
                            loading = true;
                            widget._stateManager
                                .subscribePackage(_selectedPackageId);
                          });
                        },
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
