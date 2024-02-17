// import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
// import 'package:dpl_ecommerce/customs/custom_image_view.dart';
// import 'package:dpl_ecommerce/utils/constants/image_data.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter/material.dart';

// class XCNhNThanhToNYScreen extends StatefulWidget {
//   const XCNhNThanhToNYScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   XCNhNThanhToNYScreenState createState() => XCNhNThanhToNYScreenState();
// }

// class XCNhNThanhToNYScreenState extends State<XCNhNThanhToNYScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           width: double.maxFinite,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildUnion(context),
//               SizedBox(height: 14.h),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: 16.h,
//                           right: 52.h,
//                         ),
//                         child: _buildSixtyNine(
//                           context,
//                           loremIpsumIsSy: "msg_lorem_ipsum_is_sy",
//                           widget: "lbl_901_600",
//                           sLNg: "lbl_s_l_ng",
//                           one: "lbl_1",
//                         ),
//                       ),
//                       SizedBox(height: 19.h),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Divider(
//                           indent: 15.h,
//                           endIndent: 15.h,
//                         ),
//                       ),
//                       SizedBox(height: 14.h),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: 16.h,
//                           right: 52.h,
//                         ),
//                         child: _buildSixtyNine(
//                           context,
//                           loremIpsumIsSy: "msg_lorem_ipsum_is_sy",
//                           widget: "lbl_901_600",
//                           sLNg: "lbl_s_l_ng",
//                           one: "lbl_1",
//                         ),
//                       ),
//                       SizedBox(height: 19.h),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Divider(
//                           indent: 15.h,
//                           endIndent: 15.h,
//                         ),
//                       ),
//                       SizedBox(height: 3.h),
//                       Padding(
//                         padding: EdgeInsets.only(left: 16.h),
//                         child: Text(
//                           "lbl_m_gi_m_gi",
//                           // style: CustomTextStyles.titleMedium18,
//                         ),
//                       ),
//                       SizedBox(height: 14.h),
//                       _buildSeventeen(context),
//                       SizedBox(height: 15.h),
//                       Divider(
//                         color: Colors.grey,
//                       ),
//                       SizedBox(height: 14.h),
//                       Padding(
//                         padding: EdgeInsets.only(left: 16.h),
//                         child: Text(
//                           "lbl_a_ch_c_a_b_n",
//                           // style: CustomTextStyles.titleMedium18,
//                         ),
//                       ),
//                       SizedBox(height: 14.h),
//                       _buildSixteen(context),
//                       SizedBox(height: 16.h),
//                       Divider(
//                         color: Colors.grey,
//                       ),
//                       SizedBox(height: 15.h),
//                       Padding(
//                         padding: EdgeInsets.only(left: 16.h),
//                         child: Text(
//                           "msg_ph_ng_th_c_thanh",
//                           // style: CustomTextStyles.titleMedium18,
//                         ),
//                       ),
//                       SizedBox(height: 29.h),
//                       SizedBox(height: 29.h),
//                       _buildSeventyFour(context),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildUnion(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(right: 1.h),
//       decoration: BoxDecoration(
//         color: Color(0XFFFFFFFF).withOpacity(0.95),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0XFF000000).withOpacity(0.05),
//             spreadRadius: 2.h,
//             blurRadius: 2.h,
//             offset: Offset(
//               0,
//               4,
//             ),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // CustomAppBar(
//           //   leadingWidth: 64.h,
//           //   leading: AppbarLeadingImage(
//           //     imagePath: ImageConstant.imgService,
//           //     margin: EdgeInsets.only(
//           //       left: 27.h,
//           //       top: 11.v,
//           //       bottom: 5.v,
//           //     ),
//           //   ),
//           //   centerTitle: true,
//           //   title: AppbarTitleImage(
//           //     imagePath: ImageConstant.imgUnion,
//           //   ),
//           //   actions: [
//           //     AppbarTrailingImage(
//           //       imagePath: ImageConstant.imgBattery,
//           //       margin: EdgeInsets.fromLTRB(25.h, 11.v, 25.h, 5.v),
//           //     ),
//           //   ],
//           // ),
//           Padding(
//             padding: EdgeInsets.only(left: 14.h),
//             child: Row(
//               children: [
//                 CustomImageView(
//                   imagePath: ImageData.appLogo,
//                   height: 26.h,
//                   width: 26.h,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 79.h,
//                     top: 6.h,
//                   ),
//                   child: Text(
//                     "msg_x_c_nh_n_thanh_to_n",
//                     // style: CustomTextStyles.titleMedium18,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20.h),
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildSeventeen(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 15.h),
//         padding: EdgeInsets.symmetric(
//           horizontal: 6.w,
//           vertical: 10.h,
//         ),
//         decoration: BoxDecoration(
//           color: Color(0XFFF3F3F3),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(
//                 left: 6.h,
//                 bottom: 3.h,
//               ),
//               child: Text(
//                 "lbl_blackfriday50",
//                 // style: theme.textTheme.bodyLarge,
//               ),
//             ),
//             CustomImageView(
//               imagePath: ImageData.appLogo,
//               height: 12.h,
//               width: 12.h,
//               margin: EdgeInsets.only(
//                 left: 11.w,
//                 top: 3.h,
//                 bottom: 3.h,
//               ),
//             ),
//             Spacer(),
//             CustomImageView(
//               imagePath: ImageData.appLogo,
//               height: 16.h,
//               width: 15.w,
//               margin: EdgeInsets.symmetric(vertical: 2.h),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildSixteen(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 15.h),
//         padding: EdgeInsets.symmetric(
//           horizontal: 13.w,
//           vertical: 12.h,
//         ),
//         decoration: BoxDecoration(
//           color: Color(0XFFF3F3F3),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(right: 1.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "lbl_tran_trung",
//                     // style: theme.textTheme.titleMedium,
//                   ),
//                   Text(
//                     "lbl_thay_i",
//                     // style: CustomTextStyles.bodyMediumRed500,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 6.h),
//             Text(
//               "lbl_0966_123_456",
//               // style: CustomTextStyles.bodyLargeGray600,
//             ),
//             SizedBox(height: 9.h),
//             Text(
//               "lbl_h_n_i",
//               // style: CustomTextStyles.bodyLargeGray600,
//             ),
//             SizedBox(height: 7.h),
//             Text(
//               "msg_s_123_nguy_n_tr_i",
//               // style: CustomTextStyles.bodyLargeGray600,
//             ),
//             SizedBox(height: 4.h),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   // Widget _buildThanhToNKhiNhN(BuildContext context) {
//   //   return Padding(
//   //         padding: EdgeInsets.only(left: 16.h),
//   //         child: CustomRadioButton(
//   //           text: "msg_thanh_to_n_khi_nh_n".tr,
//   //           value: "msg_thanh_to_n_khi_nh_n".tr ?? "",
//   //           groupValue: provider.radioGroup,
//   //           onChange: (value) {
//   //             provider.changeRadioButton(value);
//   //           },
//   //         ),

//   //   );
//   // }

//   /// Section Widget
//   Widget _buildSeventyFour(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 1.h),
//       padding: EdgeInsets.symmetric(
//         horizontal: 13.w,
//         vertical: 16.h,
//       ),
//       decoration: BoxDecoration(
//         color: Color(0XFF000000),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0XFF000000).withOpacity(0.05),
//             spreadRadius: 2.h,
//             blurRadius: 2.h,
//             offset: Offset(
//               0,
//               0,
//             ),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//             height: 73.h,
//             width: 384.h,
//             child: Stack(
//               alignment: Alignment.centerLeft,
//               children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 3.h),
//                     child: Text(
//                       "lbl_t_m_t_nh",
//                       // style: theme.textTheme.bodyLarge,
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "lbl_voucher",
//                     // style: theme.textTheme.bodyLarge,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Text(
//                     "lbl_ph_v_n_chuy_n",
//                     // style: theme.textTheme.bodyLarge,
//                   ),
//                 ),
//                 CustomImageView(
//                   imagePath: ImageData.appLogo,
//                   height: 12.h,
//                   width: 12.h,
//                   alignment: Alignment.bottomLeft,
//                   margin: EdgeInsets.only(
//                     left: 114.h,
//                     bottom: 3.h,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 1.h),
//                     child: Text(
//                       "lbl_2_000_000",
//                       // style: theme.textTheme.bodyLarge,
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     "lbl_100_000",
//                     // style: theme.textTheme.bodyLarge,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: Text(
//                     "lbl",
//                     // style: theme.textTheme.bodyLarge,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 15.w,
//                       vertical: 7.h,
//                     ),
//                     // decoration: BoxDecoration(
//                     //   image: DecorationImage(
//                     //     image: fs.Svg(
//                     //       ImageConstant.imgGroup18,
//                     //     ),
//                     //     fit: BoxFit.cover,
//                     //   ),
//                     // ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SizedBox(height: 6.h),
//                         Container(
//                           width: 348.h,
//                           margin: EdgeInsets.only(right: 5.h),
//                           child: Text(
//                             "msg_ph_v_n_chuy_n_kh_ch",
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             // style: CustomTextStyles.bodyMediumWhiteA700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 9.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "lbl_t_ng_gi_ti_n",
//                 // style: theme.textTheme.bodyLarge,
//               ),
//               Text(
//                 "lbl_1_900_000",
//                 // style: CustomTextStyles.titleMediumBold,
//               ),
//             ],
//           ),
//           SizedBox(height: 23.h),
//           CustomElevatedButton(
//             text: "lbl_t_h_ng",
//             height: 50.h,
//             buttonStyle: ButtonStyle(
//                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)))),
//           )
//           // CustomElevatedButton(
//           //   height: 50.v,
//           //   text: "lbl_t_h_ng".tr,
//           //   buttonStyle: CustomButtonStyles.none,
//           //   decoration:
//           //       CustomButtonStyles.gradientPrimaryToDeepOrangeDecoration,
//           //   buttonTextStyle: CustomTextStyles.titleMediumWhiteA700SemiBold,
//           // ),
//         ],
//       ),
//     );
//   }

//   /// Common widget
//   Widget _buildSixtyNine(
//     BuildContext context, {
//     required String loremIpsumIsSy,
//     required String widget,
//     required String sLNg,
//     required String one,
//   }) {
//     return Row(
//       children: [
//         CustomImageView(
//           imagePath: ImageData.googleLogo,
//           height: 120.h,
//           width: 110.h,
//           radius: BorderRadius.circular(
//             5.h,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//             left: 8.h,
//             bottom: 4.h,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 loremIpsumIsSy,
//                 // style: CustomTextStyles.titleMedium18.copyWith(
//                 //   color: appTheme.black90001,
//                 // ),
//               ),
//               SizedBox(height: 43.h),
//               Text(
//                 widget,
//                 // style: CustomTextStyles.titleMediumRed500.copyWith(
//                 //   color: appTheme.red500,
//                 // ),
//               ),
//               SizedBox(height: 19.h),
//               Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 1.h),
//                     child: Text(
//                       sLNg,
//                       // style: CustomTextStyles.bodyLargeGray600.copyWith(
//                       //   color: appTheme.gray600,
//                       // ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 6.h),
//                     child: Text(
//                       one,
//                       // style: theme.textTheme.titleMedium!.copyWith(
//                       //   color: appTheme.black90001,
//                       // ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
