import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/address_edit.dart';
import 'package:dpl_ecommerce/views/consumer/screens/checkout_page.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({Key? key}) : super(key: key);

  @override
  _AddresslistItemWidgetState createState() => _AddresslistItemWidgetState();
}

class _AddresslistItemWidgetState extends State<AddressScreen> {
  List<AddressInfor> addresses = [
    AddressInfor(name: "Hanu1", city: "NewYork", state: "street 123"),
    AddressInfor(name: "Hanu2", city: "NewYork", state: "street 123"),
    AddressInfor(name: "Hanu3", city: "NewYork", state: "street 123"),
    AddressInfor(name: "Hanu4", city: "NewYork", state: "street 123"),
    AddressInfor(name: "Hanu5", city: "NewYork", state: "street 123"),
    // Add more addresses if needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Address",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,

          //leading: Icon(Icons.menu),
        ), 
      body: ListView.builder(
        itemCount: addresses.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) {
           AddressInfor address = addresses[index];
          return Column(
            children: [
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 23.h,
                  vertical: 21.v,
                ),
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: Colors.grey,
                width:1 ,
              ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                       '${addresses[index].name}',
                      style: theme.textTheme.titleSmall,
                    ),
                    SizedBox(height: 19.v),
                    Container(
                      width: 264.h,
                      margin: EdgeInsets.only(right: 30.h),
                      child: Text(
                        '${addresses[index].city}',
                        style: theme.textTheme.bodySmall,
                        maxLines: 2,
                        
                      ),
                    ),
                    SizedBox(height: 14.v),
                    Text(
                      '${addresses[index].state}',
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 18.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector
                        (
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressForm(),
                              ),
                            ),
                          child: Container(
                            width: 150,
                            height: 40,
                           
                             child: Center(child: Text("Edit",style: TextStyle(
                          fontSize: 16,
                           color: Colors.black54
                                              ),)),
                                              decoration: BoxDecoration(//color: Colors.white,
                                              border: Border.all(
                          color: Color.fromARGB(35, 0, 0, 0),
                              width: 1,
                            ),
                                              borderRadius: BorderRadius.circular(5)
                                              ),
                            
                          ),
                        ),
                        // CustomOutlinedButton(
                        //   width: 150,
                        //     height: 40,
                        //   text: "Delete",
                        //   buttonTextStyle: TextStyle(color: Colors.blue),
                        // ),
                        CustomOutlinedButton(
                      width: 150,
                      height: 40,
                      text: "Delete",
                       buttonTextStyle: TextStyle(color: Colors.black54),
                      
                      // Add onPressed callback for the Delete button
                      onPressed: () {
                        // Add your logic for deleting here
                        // For example, you can show a confirmation dialog and then delete the address
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Delete Address"),
                            content: Text("Are you sure you want to delete this address?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Add logic to delete the address here
                                  // You can use setState or any state management solution to update the UI
                                  setState(() {
                                        addresses.removeAt(index);
                                      });
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text("Delete"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                      
                        
                        
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
      bottomNavigationBar: _buildAddAddressButton(context),
    );
  }
}
Widget _buildAddAddressButton(BuildContext context) {
    return CustomElevatedButton(
      height: 40,
      width: 370,
        text: "Add Address",
        buttonTextStyle: TextStyle(fontSize: 18),
        margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 25.v));
  }
