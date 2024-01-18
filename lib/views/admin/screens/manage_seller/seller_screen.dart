import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/verification_form.dart';
import 'package:dpl_ecommerce/repositories/verification_form_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/admin/screens/manage_seller/add_seller_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/manage_seller/seller_detail.dart';
import 'package:dpl_ecommerce/views/admin/screens/manage_seller/seller_infor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerScreen extends StatefulWidget {
  SellerScreen({super.key, this.isDrawer = false});
  bool isDrawer;

  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  VerificationFormRepo verificationFormRepo = VerificationFormRepo();
  List<UserModel>? listVerifiedSeller;
  List<UserModel>? listUnverifiedSeller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
  }

  Future<void> fetchData() async {
    listVerifiedSeller = await verificationFormRepo.getListVerifiedSeller();
    listUnverifiedSeller = await verificationFormRepo.getListUnVerifiedSeller();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void reset() {
    listVerifiedSeller = null;
    listUnverifiedSeller = null;
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  Future<void> _navigateToShopDetail(String shopID, String sellerID) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShopDetails(
            sellerID: sellerID,
            shopID: shopID,
          ),
        )).whenComplete(() async {
      await onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   heroTag: "bt1",
      //   onPressed: () async {
      //     final result = await Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => AddSellerScreen(),
      //       ),
      //     ).whenComplete(() async {
      //       await onRefresh();
      //     });
      //   },
      //   child: const Icon(Icons.add),
      // ),
      appBar: AppBar(
        backgroundColor: MyTheme.accent_color,
        automaticallyImplyLeading: widget.isDrawer,
        title: Text(LangText(context: context).getLocal()!.shop_ucf),
        centerTitle: true,
        leading: widget.isDrawer ? CustomArrayBackWidget() : Container(),
        bottom: TabBar(
          indicatorColor: MyTheme.white,
          controller: _tabController,
          tabs: [
            Tab(text: LangText(context: context).getLocal()!.confirmed_ucf),
            Tab(
              text: LangText(context: context).getLocal()!.unconfirmed_ucf,
            ),
            // Tab(text: LangText(context: context).getLocal()!.denied_ucf),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildConfirmedList(context),
          buildUnConfirmedList(context),
        ],
      ),
    );
  }

  Widget buildConfirmedList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : listVerifiedSeller != null && listVerifiedSeller!.isNotEmpty
              ? ListView.builder(
                  itemCount: listVerifiedSeller!.length,
                  itemBuilder: (context, index) {
                    final user = listVerifiedSeller![index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                      child: SingleChildScrollView(
                        child: GestureDetector(
                          onTap: () async {
                            await _navigateToShopDetail(
                                user.userInfor!.sellerInfor!.shopIDs![0],
                                user.id!);
                          },
                          child: Container(
                            //height: 120.h,
                            width: 340.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0)),
                              ],
                            ),
                            child: Material(
                              //color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.r),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    height: 80.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          '${user.firstName}',
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Text(
                                          '${user.email}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        user.phone != null
                                            ? Text(
                                                user.phone ?? "",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     Container(
                                  //       // decoration: BoxDecoration(
                                  //       //   shape: BoxShape.circle,
                                  //       //   color: Colors.grey.shade200,
                                  //       // ),
                                  //       child: IconButton(
                                  //         color: Colors.red,
                                  //         icon: const Icon(Icons.cancel),
                                  //         onPressed: () => cancelVerificationForm(
                                  //             VerificationForm),
                                  //       ),
                                  //     ),
                                  //     //SizedBox(width: 10.w,),
                                  //     Container(
                                  //       // decoration: BoxDecoration(
                                  //       //   shape: BoxShape.circle,
                                  //       //   color: Colors.grey.shade200,
                                  //       // ),
                                  //       child: IconButton(
                                  //         color: Colors.green,
                                  //         icon: const Icon(Icons.check_circle),
                                  //         onPressed: () =>
                                  //             confirmVerificationForm(
                                  //                 VerificationForm),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(LangText(context: context)
                      .getLocal()!
                      .no_data_is_available),
                ),
    );
  }

  Widget buildUnConfirmedList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : listUnverifiedSeller != null && listUnverifiedSeller!.isNotEmpty
              ? ListView.builder(
                  itemCount: listUnverifiedSeller!.length,
                  itemBuilder: (context, index) {
                    final user = listUnverifiedSeller![index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                      child: SingleChildScrollView(
                        child: GestureDetector(
                          onTap: () async {
                            await _navigateToShopDetail(
                                user.userInfor!.sellerInfor!.shopIDs![0],
                                user.id!);
                          },
                          child: Container(
                            //height: 120.h,
                            width: 340.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0)),
                              ],
                            ),
                            child: Material(
                              //color: Colors.blue,
                              borderRadius: BorderRadius.circular(8.r),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    height: 80.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          '${user.firstName}',
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Text(
                                          '${user.email}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        user.phone != null
                                            ? Text(
                                                user.phone ?? "",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  //                     Spacer(),
                                  //                     Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     IconButton(
                                  //       icon: Icon(Icons.check),
                                  //       onPressed: () => confirmVerificationForm(VerificationForm),
                                  //     ),
                                  //     IconButton(
                                  //       icon: Icon(Icons.cancel),
                                  //       onPressed: () => cancelVerificationForm(VerificationForm),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(LangText(context: context)
                      .getLocal()!
                      .no_data_is_available),
                ),
    );
  }

  // Widget buildDeniedList(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: confirmingVerificationForms.length,
  //     itemBuilder: (context, index) {
  //       final VerificationForm = confirmingVerificationForms[index];
  //       return Padding(
  //         padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
  //         child: SingleChildScrollView(
  //           child: GestureDetector(
  //             onTap: () => _ToVerificationDetail(VerificationForm),
  //             child: Container(
  //               //height: 120.h,
  //               width: 340.w,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(10.r),
  //                 boxShadow: const [
  //                   BoxShadow(
  //                       color: Colors.grey,
  //                       blurRadius: 10,
  //                       spreadRadius: 0,
  //                       offset: Offset(0, 0)),
  //                 ],
  //               ),
  //               child: Material(
  //                 //color: Colors.blue,
  //                 borderRadius: BorderRadius.circular(8.r),
  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     SizedBox(
  //                       width: 10.w,
  //                     ),
  //                     Container(
  //                       height: 80.h,
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           SizedBox(
  //                             height: 10.h,
  //                           ),
  //                           Text(
  //                             '${VerificationForm.shopName}',
  //                             style: TextStyle(fontSize: 16.sp),
  //                           ),
  //                           Text(
  //                             '${VerificationForm.email}',
  //                             style: TextStyle(
  //                               fontSize: 16.sp,
  //                               color: Colors.grey,
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 5.h,
  //                           ),
  //                           Text(
  //                             '${VerificationForm.phoneNumber}',
  //                             style: TextStyle(
  //                                 fontSize: 16.sp, fontWeight: FontWeight.bold),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     //                     Spacer(),
  //                     //                     Row(
  //                     //   mainAxisSize: MainAxisSize.min,
  //                     //   children: [
  //                     //     IconButton(
  //                     //       icon: Icon(Icons.check),
  //                     //       onPressed: () => confirmVerificationForm(VerificationForm),
  //                     //     ),
  //                     //     IconButton(
  //                     //       icon: Icon(Icons.cancel),
  //                     //       onPressed: () => cancelVerificationForm(VerificationForm),
  //                     //     ),
  //                     //   ],
  //                     // ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
