import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/model/package/packages.model.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:c4d/module_init/ui/widget/package_card/package_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InitAccountStatePackagesLoaded extends InitAccountState {
  List<PackageModel> packages;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedCity;
  String _selectedSize;
  int _selectedPackageId;

  InitAccountStatePackagesLoaded(
    this.packages,
    InitAccountScreenState screen,
  ) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: S.of(context).storeName,
                            labelText: S.of(context).storeName,
                          ),
                          validator: (name) {
                            if (name.isEmpty) {
                              return S.of(context).nameIsRequired;
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: S.of(context).storePhone,
                            labelText: S.of(context).storePhone,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (phone) {
                            if (phone.isEmpty) {
                              return S.of(context).phoneIsRequired;
                            }
                            return null;
                          },
                        ),
                        //size
                        DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                              value: _selectedSize,
                              decoration: InputDecoration(
                                hintText: S.of(context).chooseYourSize,
                                hintMaxLines: 2,
                                helperMaxLines: 2,
                              ),
                              items: _getSizes(context),
                              onChanged: (value) {
                                _selectedCity = value;
                              }),
                        ),
                        //city
                        Container(
                          child: DropdownButtonFormField(
                            // value: _selectedCity,
                              decoration: InputDecoration(
                                hintText: S.of(context).chooseYourCity,
                              ),
                              items: _getCities(),
                              onChanged: (value) {
                                _selectedCity = value;
                                screen.refresh();
                              }),
                        ),
                        //package
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: _selectedCity == null ? 0 : 196,
                          margin: EdgeInsets.only(top: 20),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _getPackages(),
                          ),
                        ),
                        // Submit Package
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          margin: EdgeInsets.only(top: 30),
                          height: _selectedPackageId == null ? 0 : 36,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              screen.subscribeToPackage(
                                _selectedPackageId,
                                _nameController.text,
                                _phoneController.text,
                                _selectedCity,
                              );
                            },
                            child: Text(
                              S.of(context).next,
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
              ),
            ),
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                        blurRadius: 4
                      )],
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FaIcon(FontAwesomeIcons.store),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPackages() {
    if (packages == null) {
      return [];
    }
    if (packages.isEmpty) {
      return [];
    }
    if (_selectedCity == null) {
      return [];
    }

    return packages.map((element) {
      return GestureDetector(
        onTap: () {
          _selectedPackageId = element.id;
          screen.refresh();
        },
        child: PackageCard(
          package: element,
          active: element.id == _selectedPackageId,
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem> _getCities() {
    var cityNames = <String>{};
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

  List<DropdownMenuItem> _getSizes(BuildContext context) {
    var sizeDropdowns = <DropdownMenuItem>[];
    sizeDropdowns.add(DropdownMenuItem(
      child: Text(S.of(context).smallLessThan20Employee),
      value: 'sm',
    ));
    sizeDropdowns.add(DropdownMenuItem(
      child: Text(S.of(context).mediumMoreThan20EmployeesLessThan100),
      value: 'md',
    ));
    sizeDropdowns.add(DropdownMenuItem(
      child: Text(S.of(context).largeMoreThan100Employees),
      value: 'lg',
    ));

    return sizeDropdowns;
  }
}
