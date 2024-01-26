import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RankUser extends StatefulWidget {
  const RankUser({super.key});

  @override
  State<RankUser> createState() => __RankUserState();
}

class __RankUserState extends State<RankUser> {
  ConsumerInfor c = new ConsumerInfor(
    raking: Raking.gold,
    rewardPoints: 100,
  );

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    final userInfor = user!.userInfor!.consumerInfor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
              backgroundColor: Colors.transparent,
              title:
                  LangText(context: context).getLocal()!.award_point_and_raking,
              centerTitle: true,
              context: context)
          .show(),
      backgroundColor: Colors.blue,
      //const Color.fromARGB(255, 158, 158, 158),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.blue,
            Colors.lightBlue,
            Colors.blueGrey,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                userInfor!.raking == Raking.bronze
                    ? Image(
                        height: 200.h,
                        width: 200.w,
                        image: NetworkImage(
                            'https://theglobalgaming.com/assets/images/_generated/assets/images/article/_webp/621d1f3d2f3259583ac14d32_Bronze-1-Valorant-Rank_5b62ede0d052bbfec4a91954e120af6e.webp'),
                      )
                    : Container(),
                userInfor.raking == Raking.silver
                    ? Image(
                        height: 200.h,
                        width: 200.w,
                        image: NetworkImage(
                            'https://theglobalgaming.com/assets/images/_generated/assets/images/article/_webp/621d219307575c079d2cb0f2_TX_CompetitiveTier_Large_9-2_5b62ede0d052bbfec4a91954e120af6e.webp'),
                      )
                    : Container(),
                userInfor.raking == Raking.gold
                    ? Image(
                        height: 200.h,
                        width: 200.w,
                        image: NetworkImage(
                            'https://theglobalgaming.com/assets/images/_generated/assets/images/article/_webp/621d219523a1b86a1bf13e06_TX_CompetitiveTier_Large_12-2_5b62ede0d052bbfec4a91954e120af6e.webp'),
                      )
                    : Container(),
                SizedBox(
                  height: 40.h,
                ),
                userInfor.raking == Raking.bronze
                    ? Text(
                        LangText(context: context)
                            .getLocal()!
                            .you_are_at_bronze_rank,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w500),
                      )
                    : Container(),
                userInfor.raking == Raking.silver
                    ? Text(
                        LangText(context: context)
                            .getLocal()!
                            .you_are_at_silver_rank,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w500),
                      )
                    : Container(),
                userInfor.raking == Raking.gold
                    ? Text(
                        LangText(context: context)
                            .getLocal()!
                            .you_are_at_gold_rank,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w500),
                      )
                    : Container(),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Container(
                      height: 100.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LangText(context: context).getLocal()!.your_rank,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          userInfor.raking == Raking.bronze
                              ? Text(
                                  LangText(context: context)
                                      .getLocal()!
                                      .bronze_ucf,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.sp, color: Colors.grey),
                                )
                              : Container(),
                          userInfor.raking == Raking.silver
                              ? Text(
                                  LangText(context: context)
                                      .getLocal()!
                                      .silver_ucf,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.sp, color: Colors.grey),
                                )
                              : Container(),
                          userInfor.raking == Raking.gold
                              ? Text(
                                  LangText(context: context)
                                      .getLocal()!
                                      .gold_ucf,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.sp, color: Colors.grey),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 100.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 3.h),
                            child: Text(
                              LangText(context: context).getLocal()!.your_score,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            userInfor.rewardPoints.toString(),
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
