import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/add_address.dart';
import 'package:dpl_ecommerce/views/consumer/screens/address_edit.dart';
import 'package:dpl_ecommerce/views/consumer/screens/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({Key? key}) : super(key: key);
  UserRepo userRepo = UserRepo();

  // Stream<void> fetchData()async*{
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    final currentUser = userProvider.userModel;
    // final listAddress = currentUser!.userInfor!.consumerInfor == null
    //     ? []
    //     : currentUser.userInfor!.consumerInfor!.addressInfors;
    return Scaffold(
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
        backgroundColor: MyTheme.accent_color,
        title: Text(
          LangText(context: context).getLocal()!.address_ucf,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MyTheme.white,
          ),
        ),
        centerTitle: true,

        //leading: Icon(Icons.menu),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
                itemBuilder: (context, index) => ShimmerHelper()
                    .buildBasicShimmer(
                        height: MediaQuery.of(context).size.height * 0.01,
                        width: MediaQuery.of(context).size.width * 0.9),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                itemCount: 4);
          } else {
            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
              final listAddress = snapshot.data;
              return ListView.builder(
                  itemCount: listAddress!.length,
                  padding: EdgeInsets.all(15.h),
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
                              height: 20.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 23.h,
                                vertical: 21.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.r),
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
                                          decoration: BoxDecoration(
                                              //color: Colors.white,
                                              border: Border.all(
                                                color:
                                                    Color.fromARGB(35, 0, 0, 0),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          child: Center(
                                              child: Text(
                                            LangText(context: context)
                                                .getLocal()!
                                                .edit_ucf,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black54),
                                          )),
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
                                        text: LangText(context: context)
                                            .getLocal()!
                                            .delete_ucf,
                                        buttonTextStyle:
                                            TextStyle(color: Colors.black54),

                                        // Add onPressed callback for the Delete button
                                        onPressed: () {
                                          // Add your logic for deleting here
                                          // For example, you can show a confirmation dialog and then delete the address
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: Text(
                                                  LangText(context: context)
                                                      .getLocal()!
                                                      .delete_address),
                                              content: Text(LangText(
                                                      context: context)
                                                  .getLocal()!
                                                  .are_you_sure_to_delete_address),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(_).pop();
                                                  },
                                                  child: Text(
                                                      LangText(context: context)
                                                          .getLocal()!
                                                          .cancel_all_lower),
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
                                                    Navigator.of(_)
                                                        .pop(); // Close the dialog
                                                  },
                                                  child: Text(
                                                      LangText(context: context)
                                                          .getLocal()!
                                                          .delete_ucf),
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
                child: Text(LangText(context: context).getLocal()!.no_address),
              );
            }
          }
        },
        stream: userRepo.getAllAddressInfor(currentUser!.id!),
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
      height: 40.h,
      buttonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MyTheme.white)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: MyTheme.accent_color, width: 0.5)),
      width: MediaQuery.of(context).size.width * 0.9,
      text: LangText(context: context).getLocal()!.add_new_address,
      buttonTextStyle: TextStyle(fontSize: 18.sp, color: MyTheme.accent_color),
      margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 25.h));
}
