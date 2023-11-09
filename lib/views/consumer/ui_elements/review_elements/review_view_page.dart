import 'package:dpl_ecommerce/const/app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/review_elements/list_review_view.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListReviewView(),
      ),
    );
  }
}
