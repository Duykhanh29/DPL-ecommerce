import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/admin/screens/category/add_category.dart';
import 'package:dpl_ecommerce/views/admin/screens/category/edit_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CategoryListScreen extends StatefulWidget {
  CategoryListScreen({super.key, this.isDrawer = false});
  bool isDrawer;
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List<Category>? categories;
  CategoryRepo categoryRepo = CategoryRepo();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    categories = await categoryRepo.getListCategory();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void reset() {
    categories = null;
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  onPressDelete(cateID) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding:
            EdgeInsets.only(top: 16.h, left: 2.w, right: 2.w, bottom: 2.h),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
          child: Text(
            AppLocalizations.of(context)!.are_you_sure_to_remove_this_item,
            maxLines: 3,
            textAlign: TextAlign.center,
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
              await categoryRepo.deleteCategory(cateID);
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
          LangText(context: context).getLocal()!.categories_ucf,
          style: TextStyle(fontWeight: FontWeight.w700, color: MyTheme.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategoryScreen()),
                ).whenComplete(() async {
                  await onRefresh();
                });
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            child: buildListCategory(context)),
      ),
    );
  }

  Widget buildListCategory(BuildContext context) {
    if (isLoading) {
      return ListView.separated(
          itemBuilder: (context, index) => ShimmerHelper().buildBasicShimmer(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.9),
          separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
          itemCount: 12);
    } else {
      if (categories != null && categories!.isNotEmpty) {
        return ListView.builder(
          itemCount: categories!.length,
          itemBuilder: (context, index) {
            final category = categories![index];

            return Slidable(
              // Specify a key if the Slidable is dismissible.
              key: Key(category.id.toString()),
              closeOnScroll: false,
              enabled: true,
              endActionPane: ActionPane(
                closeThreshold: .2,
                extentRatio: .30,
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) async {
                      await onPressDelete(category.id);

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
              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                child: GestureDetector(
                  onTap: () async {
                    final updatedCategory = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCategoryScreen(
                          id: category.id!,
                        ),
                      ),
                    ).whenComplete(() async {
                      await onRefresh();
                    });
                    // if (updatedCategory != null &&
                    //     updatedCategory is Category) {
                    //   setState(() {
                    //     categories![index] = updatedCategory;
                    //   });
                    // }
                  },
                  child: Container(
                    height: 100.h,
                    width: 343.w,
                    decoration: BoxDecoration(
                        color: MyTheme.accent_color_2,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: MyTheme.accent_color, width: 0.3)),
                    child: Material(
                      borderRadius: BorderRadius.circular(8.r),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width * 0.42,
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                category.name ?? '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFF6F6F6),
                                ),
                              ),
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: category.logo!,
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
                              width: 150.w,
                              child: const Center(
                                child: Icon(Icons.error_outline_rounded),
                              ),
                            ),
                            placeholder: (context, url) => Image.asset(
                              ImageData.placeHolder,
                              height: 100.h,
                              width: 150.w,
                            ),
                          )
                          // Image.file(
                          //   File(
                          //       category.logo!), // Assuming logo is a file path
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

            // Dismissible(
            //   background: Container(
            //     height: 10.h,
            //     width: 100.w,
            //     // padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            //     // decoration: BoxDecoration(color: MyTheme.red),
            //     child: Center(
            //       child: Icon(
            //         Icons.delete_rounded,
            //         color: MyTheme.white,
            //       ),
            //     ),
            //   ),
            //   key: Key(category.id
            //       .toString()), // Assuming category has an 'id' property
            //   onDismissed: (direction) async {
            //     // setState(() {
            //     //   categories!.removeAt(index);
            //     // });
            //   },
            //   // onUpdate: (details) async {
            //   //   await onRefresh();
            //   // },
            //   direction: DismissDirection.endToStart,
            //   confirmDismiss: (direction) async {
            //     onPressDelete(category.id);
            //     onRefresh();
            //   },
            //   child: ,
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
