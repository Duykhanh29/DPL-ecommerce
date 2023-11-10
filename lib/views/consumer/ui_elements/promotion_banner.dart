import 'package:carousel_slider/carousel_slider.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/promotion_banner_item_widget.dart';
import 'package:flutter/cupertino.dart';

class PromotionBanner extends StatefulWidget {
  PromotionBanner({super.key});

  @override
  State<PromotionBanner> createState() => _PromotionBannerState();
}

class _PromotionBannerState extends State<PromotionBanner> {
  int sliderIndex = 0;

  List<FlashSale>? list = FlashSaleRepo().list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 206,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          scrollDirection: Axis.horizontal,
          onPageChanged: (
            index,
            reason,
          ) {
            setState(() {
              sliderIndex = index;
            });
          },
        ),
        itemCount: list!.length,
        itemBuilder: (context, index, realIndex) {
          return PromotionbannerItemWidget(
            flashSale: list![index],
          );
        },
      ),
    );
  }
}
