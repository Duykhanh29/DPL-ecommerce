import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/customs/custom_rating_bar.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewViewWidget extends StatelessWidget {
  ReviewViewWidget({super.key, this.title});
  String? title;
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
                imageUrl:
                    "https://www.befunky.com/images/prismic/82e0e255-17f9-41e0-85f1-210163b0ea34_hero-blur-image-3.jpg?auto=avif,webp&format=jpg&width=896",
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
              title ?? "amazing",
              overflow: TextOverflow.ellipsis,
              maxLines: 12,
              style: CustomTextStyles.titleSmallMedium,
            ),
          ),
          const SizedBox(height: 15),
          CustomImageView(
            imagePath: ImageData.imgFrame624880,
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
                      urlImage:
                          "https://99designs-blog.imgix.net/blog/wp-content/uploads/2016/03/web-images.jpg?auto=format&q=60&w=1600&h=824&fit=crop&crop=faces",
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
