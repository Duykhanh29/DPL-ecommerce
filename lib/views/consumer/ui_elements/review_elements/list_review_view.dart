import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/repositories/review_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/review_elements/review_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListReviewView extends StatefulWidget {
  const ListReviewView({super.key});

  @override
  State<ListReviewView> createState() => _ListReviewViewState();
}

class _ListReviewViewState extends State<ListReviewView> {
  int perPage = 3;

  int present = 0;
  List<Review> originalReviews = ReviewRepo().listReview;
  List<Review> reviews = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      setState(() {
        reviews.addAll(originalReviews.getRange(present, present + perPage));
        present = present + perPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return (index == reviews.length)
            ? _buildViewAllReviews(
                context,
                viewAllReviewsText: "See more",
              )
            : ReviewViewWidget(
                review: reviews[index],
              );
      },
      itemCount: (present <= originalReviews.length)
          ? reviews.length + 1
          : reviews.length,
    );
  }

  /// Common widget
  Widget _buildViewAllReviews(
    BuildContext context, {
    required String viewAllReviewsText,
  }) {
    return GestureDetector(
      onTap: () {
        // see more reviews
        setState(() {
          if ((present + perPage) > originalReviews.length) {
            reviews.addAll(
                originalReviews.getRange(present, originalReviews.length));
          } else {
            reviews
                .addAll(originalReviews.getRange(present, present + perPage));
          }
          present = present + perPage;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              viewAllReviewsText,
              style: CustomTextStyles.labelLargePrimaryContainer.copyWith(
                color: theme.colorScheme.primaryContainer,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageData.imgArrowRight,
            height: 24,
            width: 24,
          ),
        ],
      ),
    );
  }
}
