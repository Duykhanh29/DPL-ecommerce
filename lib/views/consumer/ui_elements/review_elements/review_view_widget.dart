import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/customs/custom_rating_bar.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/video_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewViewWidget extends StatefulWidget {
  ReviewViewWidget({super.key, required this.review});
  Review? review;

  @override
  State<ReviewViewWidget> createState() => _ReviewViewWidgetState();
}

class _ReviewViewWidgetState extends State<ReviewViewWidget> {
  StorageService storageService = StorageService();
  UserRepo userRepo = UserRepo();
  UserModel? user;
  String? avatar;
  String? name;
  bool initial = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    user = await userRepo.getUserByID(widget.review!.userID!);
    setState(() {
      initial = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.all(3.h),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black12, width: 1)),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   color: Colors.green,
          //   child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10.w,
              ),
              initial || user == null
                  ? Image.asset(
                      ImageData.circelAvatar,
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                    )
                  : CachedNetworkImage(
                      imageUrl: user!.avatar!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: size.height * 0.1,
                          width: size.width * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: imageProvider),
                              shape: BoxShape.circle),
                        );
                      },
                      placeholder: (context, url) {
                        return Container();
                      },
                      errorWidget: (context, url, error) {
                        return const CircularProgressIndicator();
                      },
                    ),
              SizedBox(
                width: 10.w,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      initial || user == null
                          ? const Text("...")
                          : Text(user!.firstName ?? "user name"),
                      CustomRatingBar(
                        initialRating: widget.review!.rating!,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                    DateHelper.convertCommonDateTime(widget.review!.time!)),
              )
            ],
            // ),
          ),
          // SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
              widget.review!.text!,
              overflow: TextOverflow.ellipsis,
              maxLines: 12,
              style: CustomTextStyles.titleSmallMedium,
            ),
          ),
          SizedBox(height: 15.h),
          if (widget.review!.resourseType == ResourseType.image) ...{
            CustomImageView(
              imagePath: widget.review!.urlMedia,
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.35,
              margin: EdgeInsets.only(left: 10.w),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: MyTheme.accent_color,
                        leading: CustomArrayBackWidget(),
                        actions: [
                          IconButton(
                              onPressed: () async {
                                await storageService.downloadAndSaveImage(
                                    widget.review!.urlMedia!, context);
                              },
                              icon: Icon(
                                Icons.download_rounded,
                                color: MyTheme.white,
                                size: 20.h,
                              ))
                        ],
                      ),
                      body: CustomPhotoView(
                        // function: () async {
                        //   await storageService.downloadAndSaveImage(
                        //       widget.review!.urlMedia!, context);
                        // },
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width * 0.9,
                        urlImage: widget.review!.urlMedia,
                      ),
                    );
                  },
                ));
              },
            ),
          } else if (widget.review!.resourseType == ResourseType.video) ...{
            VideoItemWidget(
                videoUrl: widget.review!
                    .urlMedia) // custom video ==> if tap go to video item widget
          } else
            ...{}
        ],
      ),
    );
  }
}
