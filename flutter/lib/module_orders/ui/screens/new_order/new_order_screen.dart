import 'package:c4d/module_orders/ui/screens/owner_orders/owner_orders_screen.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';


class NewOrderScreen extends StatefulWidget {
  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  List<String> _places =['branch1', 'branch2','branch3','branch4','branch5'];
  List<String> _paymentMethods =['online', 'cache','credit card'];
  String _selectedFrom ;
  String _selectedTo ;
  String _selectedPaymentMethod ;

  final TextEditingController _infoController = TextEditingController();

  TextEditingController _controller2;
  String _valueChanged2 = '';
  String _valueToValidate2 = '';
  String _valueSaved2 = '';

  @override
  void initState() {
    super.initState();
    _controller2 = TextEditingController(text: DateTime.now().toString());
    _controller2.text = '2001-10-21 15:31';
  }
  @override
  Widget build(BuildContext context) {
    return screenUi();
  }

  Widget screenUi(){
    return Scaffold(
       body: SingleChildScrollView(
         child: Container(
           padding: EdgeInsetsDirectional.fromSTEB(10, 30, 10, 30),
           child: Column(
             children: [
               Text(
                 'New Order',
                 style: TextStyle(
                   fontSize: 20,
                   color: Colors.black38,
                 ),
               ),
               SizedBox(height: 30,),
               Container(
                 width: MediaQuery.of(context).size.width*0.9,
                 padding: EdgeInsets.only(bottom: 30),
                 decoration: BoxDecoration(
                   color: Color(0xff2A2E43),
                   borderRadius: BorderRadius.circular(15),
                 ),
                 child: Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         //from
                         Container(
                           width: MediaQuery.of(context).size.width*0.48,
                           margin: EdgeInsets.only(top: 30),
                             padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             color: Color(0xff454F63),
                           ),


                               child: DropdownButtonHideUnderline(
                                 child:  DropdownButton(
                                     hint:_selectedFrom == null ? Text(
                                       'From',
                                       style: TextStyle(
                                           color: Colors.grey
                                       ),
                                     ):
                                     Text(
                                       '${_selectedFrom}',
                                       style: TextStyle(
                                           color: Colors.grey
                                       ),
                                     ),
                                     items: _places.map((String place) {
                                       return new DropdownMenuItem<String>(
                                         value: place.toString(),
                                         child: new Text(place),
                                       );
                                     }).toList(),

                                     onChanged: (value) {

                                       setState(() {
                                         _selectedFrom =_places.firstWhere((element) => element.toString() == value) ;
                                       });
                                     }),
                               )
                           ),

                         Container(
                           width: MediaQuery.of(context).size.width*0.2,
                             padding: EdgeInsets.all(5),
                           margin: EdgeInsets.only(top: 30),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             color: Color(0xff454F63),
                           ),

                             child: Center(
                               child: IconButton(
                                 onPressed: (){},
                                 icon: Icon(
                                     Icons.my_location,
                                 ),
                               ),
                             )

                         ),
                       ],
                     ),
                     //to
                     Container(
                       width: MediaQuery.of(context).size.width*0.75,
                         padding: EdgeInsets.all(5),
                       margin: EdgeInsets.only(top: 30),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: Color(0xff454F63),
                       ),
                        child: DropdownButtonHideUnderline(
                             child:  DropdownButton(
                                 hint:_selectedTo == null ? Text(
                                   'To',
                                   style: TextStyle(
                                       color: Colors.grey
                                   ),
                                 ):
                                 Text(
                                   '$_selectedTo',
                                   style: TextStyle(
                                       color: Colors.grey
                                   ),
                                 ),
                                 items: _places.map((String place) {
                                   return new DropdownMenuItem<String>(
                                     value: place.toString(),
                                     child: new Text(place),
                                   );
                                 }).toList(),

                                 onChanged: (value) {

                                   setState(() {
                                     _selectedTo =_places.firstWhere((element) => element.toString() == value) ;
                                   });
                                 }),
                           )
                       ),

                     //payment method
                     Container(
                       width: MediaQuery.of(context).size.width*0.75,
                         padding: EdgeInsets.all(5),
                       margin: EdgeInsets.only(top: 30),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: Color(0xff454F63),
                       ),

                           child: DropdownButtonHideUnderline(
                             child:  DropdownButton(
                                 hint:_selectedPaymentMethod == null ? Text(
                                   'Payment Method',
                                   style: TextStyle(
                                       color: Colors.grey
                                   ),
                                 ):
                                 Text(
                                   '$_selectedPaymentMethod',
                                   style: TextStyle(
                                       color: Colors.grey
                                   ),
                                 ),
                                 items: _paymentMethods.map((String place) {
                                   return new DropdownMenuItem<String>(
                                     value: place.toString(),
                                     child: new Text(place),
                                   );
                                 }).toList(),

                                 onChanged: (value) {

                                   setState(() {
                                     _selectedPaymentMethod =_paymentMethods.firstWhere((element) => element.toString() == value) ;
                                   });
                                 }),
                           )
                       ),


                     Container(
                       padding: EdgeInsets.all(5),
                       margin: EdgeInsets.only(top: 30),
                       width: MediaQuery.of(context).size.width*0.75,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: Color(0xff454F63),
                       ),
                       child: DateTimePicker(
                         type: DateTimePickerType.dateTimeSeparate,
                         dateMask: 'dd/MM/yyyy',
                         initialValue: DateTime.now().toString(),
                         firstDate: DateTime(2000),
                         lastDate: DateTime(2100),
//                         icon: Icon(Icons.event),
                         dateLabelText: 'Date',
                         timeLabelText: "Hour",
                         selectableDayPredicate: (date) {
                           // Disable weekend days to select from the calendar
                           if (date.weekday == 6 || date.weekday == 7) {
                             return false;
                           }

                           return true;
                         },
                         onChanged: (val) => print(val),
                         validator: (val) {
                           print(val);
                           return null;
                         },
                         onSaved: (val) => print(val),
                       ),
                     ),

                       ],
                     ),
                   ),

               //info
               Container(
                 padding: EdgeInsets.all(15),
                 margin: EdgeInsets.only(top: 20),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey[100],
                       offset: Offset(
                         0.5,
                         0.5
                       ),
                       blurRadius: 3.0, // has the effect of softening the shadow
                       spreadRadius: 3.0, // has the effect of extending the shadow
                     )
                   ],
                   color: Colors.white,
                 ),
                 width: MediaQuery.of(context).size.width * 0.9,
                 child: TextField(
                   controller: _infoController,
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: 14,
                   ),
                   maxLines: 8,
                   decoration: InputDecoration.collapsed(
                     hintText: 'Info',
                     hintStyle: TextStyle(
                       color: Colors.grey,

                     ),
                   ),
                 ),
               ),

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Container(
                     width: MediaQuery.of(context).size.width*0.4,
                     margin: EdgeInsets.only(top: 30),
                     height: 70,
                     child: FlatButton(
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(15)
                       ),
                       color:  Colors.grey[100] ,
                       onPressed: (){
                         Navigator.pop(
                           context,
                         );
                       },
                       child: Text(
                         'CANCEL',
                         style: TextStyle(
                           color: Colors.grey  ,
                         ),
                       ),
                     ),
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width*0.4,
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
                         'APPLY',
                         style: TextStyle(
                           color: Colors.white  ,
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ],
           ),
         ),
       ),
    );
  }
}
