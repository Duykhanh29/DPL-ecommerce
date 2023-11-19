import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomPhotoView extends StatelessWidget {
  CustomPhotoView(
      {super.key, this.function, this.height, this.urlImage, this.width});
  double? width;
  double? height;
  Function? function;
  String? urlImage;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: () {
        if (function != null) {
          function;
        }
      },
      child: Container(
        height: height ?? size.height * 0.8,
        width: width ?? double.infinity,
        child: PhotoView(
          minScale: PhotoViewComputedScale.covered * 0.8,
          maxScale: PhotoViewComputedScale.covered *
              4.0, // Đặt giá trị maxScale bằng minScale
          imageProvider: NetworkImage(urlImage!),
          backgroundDecoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
