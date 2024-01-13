import 'package:dpl_ecommerce/const/app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/review_elements/list_review_view.dart';
import 'package:flutter/material.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({super.key, required this.list});
  List<Review> list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.reviews_ucf,
              context: context,
              centerTitle: true)
          .show(),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: ListReviewView(list: list),
      ),
    );
  }
}
