import 'package:c4d/module_init/ui/widget/package_card/package_card.dart';
import 'package:c4d/module_orders/ui/screens/owner_orders/owner_orders_screen.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InitAccountScreen extends StatefulWidget {
  @override
  _InitAccountScreenState createState() => _InitAccountScreenState();
}

class _InitAccountScreenState extends State<InitAccountScreen> {
  List<ListItem> _cities = [
    ListItem(1, "Damascus"),
    ListItem(2, "Lattakia"),
    ListItem(3, "Allepo"),
    ListItem(4, "Homs")
  ];
  List<ListItem> _sizes = [
    ListItem(1, "1"),
    ListItem(2, "2"),
    ListItem(3, "3"),
    ListItem(4, "4")
  ];
  List<Package> _packages = [
    Package(price: 15000,carsNumber: 1,packageNumber:1 ,ordersNumber: 100),
    Package(price:20000 ,carsNumber: 3,packageNumber:2 ,ordersNumber:150 ),
    Package(price: 30000,carsNumber: 4,packageNumber:3,ordersNumber:300 ),
    Package(price: 40000,carsNumber: 6,packageNumber:4 ,ordersNumber: 500),
  ];


  ListItem _selectedCity;
  ListItem _selectedSize;

  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return screenUi();
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
          padding: EdgeInsetsDirectional.fromSTEB(10,20,10,20),
          child: Column(
            children: [
              //city
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 3.0, // has the effect of softening the shadow
                        spreadRadius: 3.0, // has the effect of extending the shadow
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      )
                    ]
                ),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),

                    child: DropdownButtonHideUnderline(
                      child:  DropdownButton(
                          hint:_selectedCity == null ? Text(
                            'Choose Your City',
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ):
                          Text(
                            '${_selectedCity.name}',
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),
                          items: _cities.map((ListItem lang) {
                            return new DropdownMenuItem<String>(
                              value: lang.value.toString(),
                              child: new Text(lang.name),
                            );
                          }).toList(),

                          onChanged: (value) {

                            setState(() {
                              _selectedCity =_cities.firstWhere((element) => element.value.toString() == value) ;
                            });
                          }),
                    )

//
                ),
              ),
              //size
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 3.0, // has the effect of softening the shadow
                        spreadRadius: 3.0, // has the effect of extending the shadow
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      )
                    ]
                ),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),

                    child: DropdownButtonHideUnderline(
                      child:  DropdownButton(
                          hint:_selectedSize == null ? Text(
                            'Choose Your Size',
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ):
                          Text(
                            '${_selectedSize.name}',
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),
                          items: _sizes.map((ListItem lang) {
                            return new DropdownMenuItem<String>(
                              value: lang.value.toString(),
                              child: new Text(lang.name),
                            );
                          }).toList(),

                          onChanged: (value) {

                            setState(() {
                              _selectedSize =_sizes.firstWhere((element) => element.value.toString() == value) ;
                              _selectedSize =_sizes.firstWhere((element) => element.value.toString() == value) ;
                            });
                          }),
                    )

//
                ),
              ),
              //package
              Container(
                height: 275,
                width: MediaQuery.of(context).size.width*0.9,
                margin: EdgeInsets.only(top:20),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _packages.length,
                    itemBuilder: (BuildContext context, int index){
                      return PackageCard(
                        index: index,
                        carsNumber: _packages[index].carsNumber,
                        ordersNumber: _packages[index].ordersNumber,
                        packageNumber: _packages[index].packageNumber,
                        price: _packages[index].price,
                        );
                    }
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                margin: EdgeInsets.only(top: 30),
                height: 70,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  color:  ProjectColors.THEME_COLOR  ,
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OwnerOrdersScreen()),
                    );
                  },
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                      color: Colors.white  ,
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

class Package {
  int packageNumber;
  int ordersNumber;
  int carsNumber;
  int price;

  Package({
    this.packageNumber,
    this.price,
    this.carsNumber,
    this.ordersNumber,
});
}