// import 'package:dpl_ecommerce/customs/custom_image_view.dart';
// import 'package:dpl_ecommerce/customs/custom_text_style.dart';
// import 'package:dpl_ecommerce/utils/constants/image_data.dart';
// import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class TwosliderItemWidget extends StatelessWidget {
//   const TwosliderItemWidget({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 16.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 30.v),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: 116.h,
//                   child: Text(
//                     "lbl_min_15_off",
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style:
//                         CustomTextStyles.headlineSmallOnErrorContainer.copyWith(
//                       height: 1.25,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 9.v),
//                 // CustomElevatedButton(
//                 //   width: 70.h,
//                 //   text: "lbl_shop_now",
//                 // ),
//               ],
//             ),
//           ),
//           CustomImageView(
//             imagePath: ImageData.imgImage,
//             height: 100.v,
//             width: 100.h,
//             margin: EdgeInsets.only(left: 47.h),
//           ),
//         ],
//       ),
//     );
//   }
// }
