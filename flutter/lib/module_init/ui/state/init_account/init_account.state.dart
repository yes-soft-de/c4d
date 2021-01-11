import 'package:c4d/module_init/model/package/packages.model.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/widget/package_card/package_card.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';

abstract class InitAccountState {
  final InitAccountScreen screen;
  InitAccountState(this.screen);

  Widget getUI(BuildContext context);
}

class InitAccountStateLoading extends InitAccountState {
  InitAccountStateLoading(screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Loading')),
    );
  }
}

class InitAccountStateError extends InitAccountState {
  final String errorMsg;

  InitAccountStateError(
    this.errorMsg,
    InitAccountScreen screen,
  ) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMsg),
      ),
    );
  }
}

class InitAccountStateSubscribeSuccess extends InitAccountState {
  InitAccountStateSubscribeSuccess(InitAccountScreen screen) : super(screen);
  @override
  Widget getUI(BuildContext context) {
    return Scaffold();
  }
}

class InitAccountStatePackagesLoaded extends InitAccountState {
  List<PackageModel> packages;

  String _selectedCity;
  String _selectedSize;
  int _selectedPackageId;

  InitAccountStatePackagesLoaded(this.packages, InitAccountScreen screen)
      : super(screen);
  @override
  Widget getUI(BuildContext context) {
    return Scaffold();
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
      body: Column(children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
          child: Column(
            children: [
              //city
              Container(
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
              Container(
                height: 275,
                margin: EdgeInsets.only(top: 20),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: packages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          screen.subscribeToPackage(_selectedPackageId);
                        },
                        child: Opacity(
                          opacity: _selectedPackageId == packages[index].id
                              ? 0.5
                              : 1.0,
                          child: PackageCard(
                            index: index,
                            carsNumber: packages[index].carCount,
                            ordersNumber: packages[index].orderCount,
                            packageNumber: packages[index].id.toString(),
                            price: packages[index].cost,
                          ),
                        ),
                      );
                    }),
              ),

              // Submit Package
              Container(
                margin: EdgeInsets.only(top: 30),
                height: 70,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: ProjectColors.THEME_COLOR,
                  onPressed: (_selectedPackageId == null)
                      ? null
                      : () {
                          screen.subscribeToPackage(_selectedPackageId);
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
      ]),
    );
  }

  List<DropdownMenuItem> _getCities() {
    var cityNames = <String>[];
    packages.forEach((element) {
      cityNames.add('${element.city}');
    });

    var cityDropDown = <DropdownMenuItem>[];
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
    packages.forEach((element) {
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
