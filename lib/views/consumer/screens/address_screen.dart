import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/add_address.dart';
import 'package:dpl_ecommerce/views/consumer/screens/address_edit.dart';
import 'package:dpl_ecommerce/views/consumer/screens/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({Key? key}) : super(key: key);
  @override
  _AddresslistItemWidgetState createState() => _AddresslistItemWidgetState();
}

class _AddresslistItemWidgetState extends State<AddressScreen> {
  UserRepo userRepo = UserRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Stream<void> fetchData()async*{
  //   yield* userFirestoreDatabase.getAddressInfors(uid)
  // }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    final currentUser = userProvider.userModel;
    // final listAddress = currentUser!.userInfor!.consumerInfor == null
    //     ? []
    //     : currentUser.userInfor!.consumerInfor!.addressInfors;
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
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            if (snapshot.data != null) {
              final listAddress = snapshot.data;
              return ListView.builder(
                  itemCount: listAddress!.length,
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    AddressInfor address = listAddress[index];
                    return GestureDetector(
                      onTap: () {
                        // userProvider.initilizeAddress(address);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 23.h,
                                vertical: 21.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${listAddress[index].name}',
                                    style: theme.textTheme.titleSmall,
                                  ),
                                  SizedBox(height: 19.h),
                                  Container(
                                    width: 264.h,
                                    margin: EdgeInsets.only(right: 30.h),
                                    child: Text(
                                      '${listAddress[index].city}',
                                      style: theme.textTheme.bodySmall,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 14.h),
                                  Text(
                                    '${listAddress[index].district}',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  SizedBox(height: 18.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditAddress(
                                                addressInfor:
                                                    listAddress[index]),
                                          ),
                                        ),
                                        child: Container(
                                          width: 110.w,
                                          height: 40.h,
                                          child: Center(
                                              child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          )),
                                          decoration: BoxDecoration(
                                              //color: Colors.white,
                                              border: Border.all(
                                                color:
                                                    Color.fromARGB(35, 0, 0, 0),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                      // CustomOutlinedButton(
                                      //   width: 150,
                                      //     height: 40,
                                      //   text: "Delete",
                                      //   buttonTextStyle: TextStyle(color: Colors.blue),
                                      // ),
                                      CustomOutlinedButton(
                                        width: 110.w,
                                        height: 40.h,
                                        text: "Delete",
                                        buttonTextStyle:
                                            TextStyle(color: Colors.black54),

                                        // Add onPressed callback for the Delete button
                                        onPressed: () {
                                          // Add your logic for deleting here
                                          // For example, you can show a confirmation dialog and then delete the address
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Delete Address"),
                                              content: Text(
                                                  "Are you sure you want to delete this address?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    // Add logic to delete the address here
                                                    // You can use setState or any state management solution to update the UI
                                                    // setState(() {
                                                    //   listAddress
                                                    //       .removeAt(index);
                                                    // });
                                                    await userRepo
                                                        .deleteAddress(
                                                            address.id!,
                                                            currentUser);
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
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
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text("No address"),
              );
            }
          }
        },
        stream: userRepo.getListAddress(currentUser!.id!),
      ),
      bottomNavigationBar: _buildAddAddressButton(context),
    );
  }
}

Widget _buildAddAddressButton(BuildContext context) {
  // final userProvider = Provider.of<UserViewModel>(context);
  return CustomElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddAddress(),
        ));
      },
      height: 40,
      width: 370,
      text: "Add Address",
      buttonTextStyle: TextStyle(fontSize: 18),
      margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 25.h));
}
