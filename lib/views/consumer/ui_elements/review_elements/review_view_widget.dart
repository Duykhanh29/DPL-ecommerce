import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/customs/custom_rating_bar.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/video_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewViewWidget extends StatelessWidget {
  ReviewViewWidget({super.key, required this.review});
  Review? review;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black12, width: 1)),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   color: Colors.green,
          //   child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              CachedNetworkImage(
                imageUrl: review!.userAvatar!,
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
                  return CircularProgressIndicator();
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("User name"),
                      CustomRatingBar(
                        initialRating: 2.5,
                      ),
                    ],
                  ),
                ),
              )
            ],
            // ),
          ),
          // SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              review!.text!,
              overflow: TextOverflow.ellipsis,
              maxLines: 12,
              style: CustomTextStyles.titleSmallMedium,
            ),
          ),
          const SizedBox(height: 15),
          if (review!.resourseType == ResourseType.image) ...{
            CustomImageView(
              imagePath: review!.urlMedia,
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.35,
              margin: EdgeInsets.only(left: 10),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        leading: CustomArrayBackWidget(),
                      ),
                      body: CustomPhotoView(
                        function: () {
                          // save to local device
                        },
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width * 0.9,
                        urlImage: review!.urlMedia,
                      ),
                    );
                  },
                ));
              },
            ),
          } else ...{
            VideoItemWidget(
                videoUrl: review!
                    .urlMedia) // custom video ==> if tap go to video item widget
          }
        ],
      ),
    );
  }
}
