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
  String _selectedCity;
  String _selectedSize;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
    widget._stateManager.getPackages();
  }

  void processEvent() {
    if (currentState is InitAccountFetchingDataSuccessState) {
      InitAccountFetchingDataSuccessState state = currentState;
      _packages = state.data;
      loading = false;
      error = false;
    }
    if (currentState is InitAccountSubscribeSuccessState) {
      Navigator.pushReplacementNamed(context, OrdersRoutes.ORDER_STATUS);
    }

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentState is InitAccountInitState) {
      return loadingUI();
    } else if (currentState is InitAccountSubscribeSuccessState) {
      return screenUi();
    } else {
      return Scaffold(
        body: Center(child: Text('Error: State ${currentState.runtimeType}')),
      );
    }
  }

  Widget loadingUI() {
    return Scaffold(
        body: Center(
      child: GestureDetector(
          onTap: () {
            widget._stateManager.getPackages();
          },
          child: CircularProgressIndicator()),
    ));
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
                      child: DropdownButtonFormField(
                          decoration:
                              InputDecoration(hintText: 'Choose Your City'),
                          items: _getCities(),
                          onChanged: (value) {
                            _selectedCity = value;
                          }),
                    )),
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
                      child: DropdownButtonFormField(
                          value: _selectedSize,
                          decoration:
                              InputDecoration(hintText: 'Choose Your Size'),
                          items: _getSizes(),
                          onChanged: (value) {
                            _selectedCity = value;
                          }),
                    )),
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

  List<DropdownMenuItem> _getCities() {
    var cityNames = <String>[];
    _packages.forEach((element) {
      cityNames.add('${element.city}');
    });

    var cityDropDown = <Widget>[];
    cityNames.forEach((element) {
      cityDropDown.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

    return cityDropDown;
  }

  List<DropdownMenuItem> _getSizes() {
    var sizeStrings = <String>[];
    _packages.forEach((element) {
      sizeStrings.add('${element.city}');
    });

    var sizeDropdowns = <DropdownMenuItem>[];
    sizeStrings.forEach((element) {
      sizeDropdowns.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

    return sizeDropdowns;
  }
}
