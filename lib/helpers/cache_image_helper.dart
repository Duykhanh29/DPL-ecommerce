import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImageHelper {
  static Widget showCacheImage(
      {required String url, required double height, required double width}) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.fitWidth,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            // colorFilter:
            //     const ColorFilter.mode(
            //         Colors.red,
            //         BlendMode
            //             .colorBurn)
          ),
        ),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
