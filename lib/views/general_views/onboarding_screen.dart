import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/main.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/general_views/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 70.h),
        child: PageView(
          controller: pageController,
          onPageChanged: (value) {
            if (value == 2) {
              setState(() {
                isLastPage = true;
              });
            }
          },
          children: [
            buildPageItem(
                color: MyTheme.background,
                image: ImageData.onboarding1,
                subtitle:
                    "Special new arrivals just for you. Let experience both of fantastic things",
                title: "Discover something new"),
            buildPageItem(
                color: MyTheme.green,
                image: ImageData.onboarding2,
                subtitle: "Favourite brands and hottest trend",
                title: "Update trendly outfits"),
            buildPageItem(
                color: MyTheme.accent_color_3,
                image: ImageData.onboarding3,
                subtitle: "Explore your true styles",
                title: "Relax and just let us bring the style for you"),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              height: 70.h,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      Size.fromHeight(70.h),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(MyTheme.accent_color_2)),
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setBool('newLaunch', true);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstScreen(),
                      ));
                },
                child: const Center(child: Icon(CupertinoIcons.forward_fill)),
              ),
            )
          : Container(
              height: 70.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      pageController.jumpToPage(2);
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: WormEffect(
                          spacing: 15.w,
                          dotColor: MyTheme.borderColor,
                          activeDotColor: MyTheme.accent_color),
                      onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(microseconds: 500),
                          curve: Curves.bounceInOut);
                    },
                    child: const Icon(Icons.arrow_forward_ios_rounded),
                  )
                ],
              ),
            ),
    );
  }

  Widget buildPageItem(
      {required Color color,
      required String title,
      required String subtitle,
      required String image}) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 60.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
