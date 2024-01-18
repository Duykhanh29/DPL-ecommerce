// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/repositories/review_repo.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/view_model/consumer/review_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:file_picker/file_picker.dart';

class RatingScreen extends StatefulWidget {
  String productID;
  String orderID;
  String orderingProductID;
  RatingScreen(
      {Key? key,
      required this.productID,
      required this.orderID,
      required this.orderingProductID})
      : super(key: key);
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<RatingScreen> {
  double rating = 3.0;
  ProductRepo productRepo = ProductRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.accent_color,
        title: Text(
          LangText(context: context).getLocal()!.rate_product,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,

        //leading: Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            RatingSection(),
            SizedBox(
              height: 30.h,
            ),
            CommentSection(),
            SizedBox(
              height: 30.h,
            ),
            ImageUploadSection(
                productID: widget.productID,
                orderID: widget.orderID,
                orderingProductID: widget.orderingProductID),
          ],
        ),
      ),
    );
  }
}

class RatingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewViewModel>(context);
    return Column(
      children: [
        // Row(
        //   children: [
        //     // Icon(Icons.gif_box_outlined),
        //     // Text('Submit your review'),
        //   ],
        // ),
        Consumer<ReviewViewModel>(
          builder: (context, providerValue, child) {
            return RatingBar.builder(
              initialRating: providerValue.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 20.h,
              ),
              onRatingUpdate: (newRating) {
                providerValue.onRatingChanged(newRating);
              },
            );
          },
        ),
      ],
    );
  }
}

class CommentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewViewModel>(context);
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(14)),
          child: Consumer<ReviewViewModel>(
            builder: (context, provider, child) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                child: TextFormField(
                  controller: provider.reviewTextEditingController,
                  decoration: InputDecoration(
                    hintText: LangText(context: context)
                        .getLocal()!
                        .write_about_this_product,
                    hintStyle:
                        TextStyle(color: Colors.black87, fontSize: 16.sp),
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    provider.onTextChanged(value);
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
      ]),
    );
  }
}

class ImageUploadSection extends StatefulWidget {
  final String productID;
  String orderID;
  String orderingProductID;
  ImageUploadSection(
      {Key? key,
      required this.productID,
      required this.orderID,
      required this.orderingProductID})
      : super(key: key);
  @override
  _ImageUploadSectionState createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends State<ImageUploadSection> {
  // ProductRepo productRepo = ProductRepo();
  ReviewRepo reviewRepo = ReviewRepo();
  OrderRepo orderRepo = OrderRepo();
  ShopRepo shopRepo = ShopRepo();
  ProductRepo productRepo = ProductRepo();
  Shop? shop;
  Product? product;
  File? _file;
  String? filePath;
  String? fileName;
  String? type;
  ResourseType? resourseType;
  StorageService storageService = StorageService();
  Future getMedia(String userID) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg', 'mp4'],
      type: FileType.custom,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile pickedFile = result.files.single;

      print('Đường dẫn tệp: ${pickedFile.path}');
      setState(() {
        filePath = pickedFile.path;
        fileName = pickedFile.name;
      });
      print('Định dạng tệp: ${pickedFile.extension}');
      // Kiểm tra định dạng tệp để thực hiện các xử lý phù hợp
      if (pickedFile.extension == 'png' || pickedFile.extension == 'jpg') {
        // Xử lý khi là ảnh
        setState(() {
          _file = File(pickedFile.path!);
          resourseType = ResourseType.image;
          type = 'images';
        });
      } else if (pickedFile.extension == 'mp4') {
        // Xử lý khi là video
        setState(() {
          _file = File(pickedFile.path!);
          resourseType = ResourseType.video;
          type = 'videos';
        });
      } else {
        // Xử lý cho các định dạng khác
      }
    } else {
      print('Không có tệp nào được chọn.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    product = await productRepo.getProductByID(widget.productID);
    if (product != null) {
      shop = await shopRepo.getShopByID(product!.shopID!);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    final reviewProvider = Provider.of<ReviewViewModel>(context);
    return Column(
      children: [
        //Text('Đăng ảnh:'),
        _file == null
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(color: Colors.black)),
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 40.h,
                  color: Colors.black38,
                ),
              )
            : Image.file(
                _file!,
                height: 200.h,
                width: 200.h,
              ),
        SizedBox(
          height: 60.h,
        ),

        CustomIconButton(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50.h,
          onTap: () async {
            await getMedia(user!.id!);
          },
          decoration: BoxDecoration(
              color: MyTheme.accent_color,
              borderRadius: BorderRadius.circular(15.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LangText(context: context).getLocal()!.add_photo_or_video,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.sp, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        CustomIconButton(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50.h,
          onTap: () async {
            if (reviewProvider.rating != 0.0) {
              String? url;
              if (fileName != null && filePath != null && _file != null) {
                bool isSuccess = await storageService.uploadFile(
                    filePath: filePath!,
                    fileName: fileName!,
                    rootRef: 'reviews',
                    secondRef: user!.id,
                    thirdRef: type);
                if (isSuccess) {
                  url = await storageService.downloadURL(
                      filePath: filePath!,
                      fileName: fileName!,
                      secondRef: user!.id!,
                      rootRef: 'reviews',
                      thirdRef: type);
                }
              }
              Review review = Review(
                  productID: widget.productID,
                  rating: reviewProvider.rating,
                  resourseType: resourseType,
                  text: reviewProvider.reviewTextEditingController.text,
                  time: Timestamp.now(),
                  userID: user!.id!,
                  urlMedia: url,
                  userName: user.firstName,
                  userAvatar: user.avatar);
              await reviewRepo.addNewReview(review);
              await orderRepo.updateRatingForProduct(
                  widget.orderID, widget.orderingProductID);
              if (shop != null) {
                await shopRepo.updateRatingCountForShop(
                    shopID: shop!.id!, rating: reviewProvider.rating);
              }

              // Navigator.of(context).pushNamedAndRemoveUntil(newRouteName, (route) => false);
              Navigator.of(context).pop();
            }
          },
          decoration: BoxDecoration(
              color: MyTheme.accent_color,
              borderRadius: BorderRadius.circular(15.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LangText(context: context).getLocal()!.submit_ucf,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.sp, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
