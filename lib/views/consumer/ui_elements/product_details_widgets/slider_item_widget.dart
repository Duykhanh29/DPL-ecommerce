import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SliderItemWidget extends StatelessWidget {
  SliderItemWidget({Key? key, required this.urlImage})
      : super(
          key: key,
        );
  String? urlImage;
  StorageService storageService = StorageService();
  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: urlImage,
      height: 342,
      width: 360,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                leading: CustomArrayBackWidget(),
                backgroundColor: MyTheme.accent_color,
                actions: [
                  IconButton(
                      onPressed: () async {
                        await storageService.downloadAndSaveImage(
                            urlImage!, context);
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

                // },
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.9,
                urlImage: urlImage,
              ),
            );
          },
        ));
      },
    );
  }
}
