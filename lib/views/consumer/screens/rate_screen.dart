// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  RatingScreen({
    Key? key,
    required this.productID,
  }) : super(key: key);
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
        backgroundColor: Colors.blue,
        title: Text(
          "Rate Product",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,

        //leading: Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            RatingSection(),
            SizedBox(
              height: 30,
            ),
            CommentSection(),
            SizedBox(
              height: 30,
            ),
            ImageUploadSection(productID: widget.productID),
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
        Row(
          children: [
            // Icon(Icons.gif_box_outlined),
            // Text('Submit your review'),
          ],
        ),
        Consumer<ReviewViewModel>(
          builder: (context, providerValue, child) {
            return RatingBar.builder(
              initialRating: providerValue.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
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
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //Text('Comment:',style: TextStyle(fontSize: 24),),
        // Thêm TextField hoặc TextFormField cho phần bình luận tại đây
        // Để đơn giản, ở đây chỉ sử dụng một TextFormField để nhập bình luận
        Container(
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(14)),
          child: Consumer<ReviewViewModel>(
            builder: (context, provider, child) {
              return TextFormField(
                controller: provider.reviewTextEditingController,
                decoration: InputDecoration(
                  hintText:
                      ' Would you like to write anything about this product?',
                  hintStyle: TextStyle(color: Colors.black87),
                ),
                maxLines: 4,
                onChanged: (value) {
                  provider.onTextChanged(value);
                },
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
  const ImageUploadSection({
    Key? key,
    required this.productID,
  }) : super(key: key);
  @override
  _ImageUploadSectionState createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends State<ImageUploadSection> {
  ProductRepo productRepo = ProductRepo();

  File? _file;
  ResourseType? resourseType;

  Future getMedia() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg', 'mp4'],
      type: FileType.custom,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile pickedFile = result.files.first;

      print('Đường dẫn tệp: ${pickedFile.path}');
      print('Định dạng tệp: ${pickedFile.extension}');

      // Kiểm tra định dạng tệp để thực hiện các xử lý phù hợp
      if (pickedFile.extension == 'png' || pickedFile.extension == 'jpg') {
        // Xử lý khi là ảnh
        setState(() {
          _file = File(pickedFile.path!);
          resourseType = ResourseType.image;
        });
        print('Đây là một tệp ảnh.');
      } else if (pickedFile.extension == 'mp4') {
        // Xử lý khi là video
        setState(() {
          _file = File(pickedFile.path!);
          resourseType = ResourseType.video;
        });
        print('Đây là một tệp video.');
      } else {
        // Xử lý cho các định dạng khác
        print('Đây không phải là một tệp ảnh hoặc video.');
      }
    } else {
      print('Không có tệp nào được chọn.');
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
                  size: 40,
                  color: Colors.black38,
                ),
              )
            : Image.file(
                _file!,
                height: 200,
              ),
        SizedBox(
          height: 60.h,
        ),

        CustomIconButton(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          onTap: () {
            getMedia();
          },
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add A Photo',
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
              Review review = Review(
                  productID: widget.productID,
                  rating: reviewProvider.rating,
                  resourseType: resourseType,
                  text: reviewProvider.reviewTextEditingController.text,
                  time: Timestamp.now(),
                  userID: user!.id!,
                  urlMedia: _file!.path,
                  userAvatar: user.avatar);
              await productRepo.addNewReview(review);
              // Navigator.of(context).pushNamedAndRemoveUntil(newRouteName, (route) => false);
            }
          },
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Submit Review',
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
