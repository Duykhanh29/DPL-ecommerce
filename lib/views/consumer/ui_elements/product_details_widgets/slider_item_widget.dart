import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderItemWidget extends StatelessWidget {
  SliderItemWidget({Key? key, required this.urlImage})
      : super(
          key: key,
        );
  String? urlImage;
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
              ),
              body: CustomPhotoView(
                function: () {
                  // save to local device
                },
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
