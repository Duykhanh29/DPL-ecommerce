import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/deliver_service.dart';
import 'package:dpl_ecommerce/repositories/deliver_service_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/admin/screens/delivery/add_delivery_service.dart';
import 'package:dpl_ecommerce/views/admin/screens/delivery/edit_delivery_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/app_theme.dart';

class DeliverListScreen extends StatefulWidget {
  DeliverListScreen({super.key, this.isDrawer = false});
  bool isDrawer;
  @override
  _DeliverListScreenState createState() => _DeliverListScreenState();
}

class _DeliverListScreenState extends State<DeliverListScreen> {
  List<DeliverService>? list;
  DeliverServiceRepo deliverServiceRepo = DeliverServiceRepo();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    list = await deliverServiceRepo.getDeliverServiceList();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void reset() {
    list = null;
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  onPressDelete(deliveryID) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding:
            EdgeInsets.only(top: 16.0, left: 2.0, right: 2.w, bottom: 2.h),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: Text(
            AppLocalizations.of(context)!.are_you_sure_to_remove_this_item,
            maxLines: 3,
            style: TextStyle(color: MyTheme.font_grey, fontSize: 14.sp),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    MyTheme.soft_accent_color)),
            child: Text(
              AppLocalizations.of(context)!.cancel_ucf,
              style: TextStyle(color: MyTheme.medium_grey),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await deliverServiceRepo.deleteDeliveryService(deliveryID);
              await onRefresh();
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    MyTheme.soft_accent_color)),
            child: Text(
              AppLocalizations.of(context)!.confirm_ucf,
              style: TextStyle(color: MyTheme.dark_grey),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.accent_color,
        centerTitle: true,
        automaticallyImplyLeading: widget.isDrawer,
        leading: widget.isDrawer ? CustomArrayBackWidget() : Container(),
        title: Text(
          LangText(context: context).getLocal()!.delivery_service_ucf,
          style: TextStyle(fontWeight: FontWeight.w700, color: MyTheme.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDeliverScreen()),
                ).whenComplete(() async {
                  await onRefresh();
                });
                // if (result != null && result is Category) {
                //   setState(() {
                //     categories.add(result);
                //   });
                // }
              })
        ],
      ),
      body: RefreshIndicator(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 10.h,
            ),
            child: buildListDelivery(context),
          ),
          onRefresh: onRefresh),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
      //     final result = await Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => AddDeliverScreen()),
      //     );
      //     if (result != null && result is DeliverService) {
      //       setState(() {
      //         categories.add(result);
      //       });
      //     }
      //   },
      // ),
    );
  }

  Widget buildListDelivery(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (list != null && list!.isNotEmpty) {
        return ListView.builder(
          itemCount: list!.length,
          itemBuilder: (context, index) {
            final deliveryService = list![index];

            return Slidable(
              // Specify a key if the Slidable is dismissible.
              key: Key(deliveryService.id.toString()),
              closeOnScroll: false,
              enabled: true,
              endActionPane: ActionPane(
                closeThreshold: .2,
                extentRatio: .30,
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) async {
                      await onPressDelete(deliveryService.id);

                      // _shopList[sellerIndex].cart_items.removeAt(index);
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    autoClose: true,
                    borderRadius: BorderRadius.circular(5.r),
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    spacing: 1,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                child: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditDeliverScreen(
                          id: deliveryService.id!,
                        ),
                      ),
                    ).whenComplete(() async {
                      await onRefresh();
                    });
                  },
                  child: Container(
                    height: 100.h,
                    width: 343.w,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: MyTheme.accent_color, width: 0.3),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width * 0.42,
                            color: MyTheme.accent_color_2,
                            child: Center(
                              child: Text(
                                deliveryService.name ?? '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFF6F6F6),
                                ),
                              ),
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: deliveryService.logo!,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 100.h,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                    image:
                                        DecorationImage(image: imageProvider)),
                              );
                            },
                            errorWidget: (context, url, error) => Container(
                              height: 100.h,
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: const Center(
                                child: Icon(Icons.error_outline_rounded),
                              ),
                            ),
                            placeholder: (context, url) => Image.asset(
                              ImageData.placeHolder,
                              height: 100.h,
                              width: MediaQuery.of(context).size.width * 0.42,
                            ),
                          )
                          // Image.file(
                          //   File(deliveryService
                          //       .logo!), // Assuming logo is a file path
                          //   height: 100.h,
                          //   width: 150.w,
                          //   fit: BoxFit.cover,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );

            //  Dismissible(
            //   direction: DismissDirection.endToStart,
            //   background: Container(
            //     width: MediaQuery.of(context).size.width * 0.2,
            //     height: 40.h,
            //     decoration: BoxDecoration(
            //         color: Colors.redAccent,
            //         borderRadius: BorderRadius.circular(5.r)),
            //     // color: Colors.redAccent,
            //     child: Center(
            //       child: Icon(
            //         Icons.delete,
            //         color: MyTheme.white,
            //       ),
            //     ),
            //   ),
            //   key: Key(deliveryService.id
            //       .toString()), // Assuming category has an 'id' property
            //   onDismissed: (direction) {},
            //   child:
            // );
          },
        );
      } else {
        return Center(
          child:
              Text(LangText(context: context).getLocal()!.no_data_is_available),
        );
      }
    }
  }
}
