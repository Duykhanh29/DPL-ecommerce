import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  ProductRepo productRepo = ProductRepo();
  ScrollController? controller = ScrollController();
  List<Product>? allProduct;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    allProduct = await productRepo.getActiveProducts();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void reset() {
    isLoading = true;
    allProduct = null;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefersh() async {
    reset();
    await fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              title: LangText(context: context).getLocal()!.products_ucf,
              context: context)
          .show(),
      body: RefreshIndicator(
          child: buildListProduct(context), onRefresh: onRefersh),
    );
  }

  Widget buildListProduct(BuildContext context) {
    if (isLoading) {
      return SizedBox(child: ShimmerHelper().buildProductGridShimmer());
    } else if (allProduct != null && allProduct!.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
        child: CustomScrollView(
          controller: controller,
          shrinkWrap: true,
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 283.h,
                  // childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  return Productsmalllist1ItemWidget(
                    product: allProduct![index],
                  );
                },
                physics: NeverScrollableScrollPhysics(),
                itemCount: allProduct!.length,
              )
            ]))
          ],
        ),
      );
    } else {
      return Center(
        child:
            Text(LangText(context: context).getLocal()!.no_data_is_available),
      );
    }
  }
}
