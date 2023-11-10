import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:flutter/material.dart';

class CategoryInterface extends StatelessWidget {
  List<Category>? list = CategoryRepo().list;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh mục'),
      ),
      body: ListView.builder(
        itemCount: list!.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            leading: CachedNetworkImage(
              imageUrl: list![index].logo!,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: imageProvider),
                      shape: BoxShape.circle),
                );
              },
              placeholder: (context, url) {
                return SizedBox(
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                );
              },
            ),
            title: Text(list![index].name!),
          );
        },
      ),
    );
  }
}
