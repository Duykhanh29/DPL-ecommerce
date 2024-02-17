// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_result_page.dart';
import 'package:flutter/material.dart';

import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';

class CategoryInterface extends StatefulWidget {
  String name;
  double? rating;
  int? minPrice;
  int? maxPrice;
  DateTime? date;
  CategoryInterface({
    this.date,
    this.maxPrice,
    this.minPrice,
    this.rating,
    Key? key,
    required this.name,
  }) : super(key: key);
  @override
  State<CategoryInterface> createState() => _CategoryInterfaceState();
}

class _CategoryInterfaceState extends State<CategoryInterface> {
  List<Category>? list;
  ProductRepo productRepo = ProductRepo();
  CategoryRepo categoryRepo = CategoryRepo();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    list = await categoryRepo.getListCategory();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.category_ucf,
              centerTitle: true,
              context: context)
          .show(),
      body: !isLoading
          ? list != null
              ? ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        final listProduct =
                            await productRepo.searchProductByNameAndCategory(
                                name: widget.name,
                                categoryID: list![index].id!);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return SearchFilterScreen(
                              searchKey: widget.name,
                              list: listProduct,
                              date: widget.date,
                              maxPrice: widget.maxPrice,
                              minPrice: widget.minPrice,
                              rating: widget.rating,
                            );
                          },
                        ));
                      },
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
                )
              : Center(
                  child: Image.asset(ImageData.imageNotFound),
                )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
