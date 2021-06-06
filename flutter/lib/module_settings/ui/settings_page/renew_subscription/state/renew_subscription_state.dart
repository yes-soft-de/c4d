import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/model/package/packages.model.dart';
import 'package:c4d/module_init/ui/widget/package_card/package_card.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_settings/ui/settings_page/renew_subscription/screen/renew_subscription.dart';
import 'package:flutter/material.dart';

abstract class RenewPcakageSubscriptionState {
  final RenewSubscriptionScreenState screenState;

  RenewPcakageSubscriptionState(this.screenState);

  Widget getUI(BuildContext context);
}

class RenewPcakageSubscriptionStateLoading
    extends RenewPcakageSubscriptionState {
  RenewPcakageSubscriptionStateLoading(RenewSubscriptionScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class RenewPcakageSubscriptionStateError extends RenewPcakageSubscriptionState {
  String errorMsg;

  RenewPcakageSubscriptionStateError(
    this.errorMsg,
    RenewSubscriptionScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errorMsg}'),
    );
  }
}

class RenewPcakageSubscriptionStateLoaded
    extends RenewPcakageSubscriptionState {
  List<PackageModel> packages;
  RenewPcakageSubscriptionStateLoaded(
    this.packages,
    RenewSubscriptionScreenState screenState,
  ) : super(screenState);
  String _selectedCity;
  int _selectedPackageId;
  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //city
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: DropdownButtonFormField(
                // value: _selectedCity,
                decoration: InputDecoration(
                  hintText: S.of(context).chooseYourCity,
                ),
                items: _getCities(),
                onChanged: (value) {
                  _selectedCity = value;
                  screenState.refresh();
                }),
          ),
        ),
        //package
        AnimatedContainer(
          duration: Duration(seconds: 1),
          height: _selectedCity == null ? 0 : 196,
          margin: EdgeInsets.only(top: 20),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _getPackages(_selectedCity),
          ),
        ),
        // Submit Package
        AnimatedContainer(
          duration: Duration(seconds: 1),
          margin: EdgeInsets.only(top: 30),
          height: _selectedPackageId == null ? 0 : 36,
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              screenState.renewSubscription(_selectedPackageId);
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
    );
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

  List<Widget> _getPackages(String city) {
    if (packages == null) {
      return [];
    }
    if (packages.isEmpty) {
      return [];
    }
    if (_selectedCity == null) {
      return [];
    }
    List<PackageModel> cityPackage = [];
    for (int i = 0; i < packages.length; i++) {
      if (packages[i].city == city) {
        cityPackage.add(packages[i]);
      }
    }
    return cityPackage.map((element) {
      return GestureDetector(
        onTap: () {
          _selectedPackageId = element.id;
          screenState.refresh();
        },
        child: PackageCard(
          package: element,
          active: element.id == _selectedPackageId,
        ),
      );
    }).toList();
  }

}
