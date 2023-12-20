import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/order_model.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/repositories/payment_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/screens/rate_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/track_order.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/list_order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'dart:html';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({Key? key, required this.order}) : super(key: key);
  // String orderID;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //backgroundColor: appTheme.gray5001,
          appBar: CustomAppBar(
                  title:
                      LangText(context: context).getLocal()!.order_details_ucf,
                  context: context,
                  centerTitle: true)
              .show(),
          //  AppBar(
          //   backgroundColor: Colors.blue,
          //   title: Text(
          //    ,
          //     textAlign: TextAlign.center,
          //   ),
          //   centerTitle: true,

          //   //leading: Icon(Icons.menu),
          // ),
          body: Padding(
            padding: EdgeInsets.only(bottom: 8.h, top: 1.h),
            child: Column(
              children: [
                DetailBody(list: order.orderingProductsID!),
                GestureDetector(
                  // onTap: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         RatingScreen(productID: orderingProduct.productID!),
                  //   ),
                  // ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50.h,
                      child: Center(
                        child: Text(
                          LangText(context: context).getLocal()!.rate_ucf,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                      ),

                      // text: "Details",
                      // buttonTextStyle: TextStyle(color: Colors.white),

                      // onPressed: () => OrderDetailScreen(),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class DetailBody extends StatelessWidget {
  DetailBody({super.key, required this.list});
  List<OrderingProduct> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      //padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 26.h),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //margin: EdgeInsets.symmetric(horizontal: 4.h),
                    //padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.h),
                    decoration: BoxDecoration(color: Colors.blue[400]),
                    child: Row(
                      ///mainAxisAlignment: MainAxisAlignment.,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 10.h, top: 3.h, bottom: 2.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    LangText(context: context)
                                        .getLocal()!
                                        .your_order_is_delivered,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.sp),
                                    //style: CustomTextStyles.titleMediumNunitoOnPrimary
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    LangText(context: context)
                                        .getLocal()!
                                        .rate_product_to_get_points,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.sp),
                                    textAlign: TextAlign.center,
                                    softWrap: true,

                                    maxLines: 7,
                                    //style: theme.textTheme.labelMedium
                                  ),
                                  SizedBox(height: 10.h),
                                ])),
                        // SizedBox(
                        //   width: 50.w,
                        // ),
                        // CustomImageView(
                        //   imagePath: ImageData.appLogo,
                        //   height: 51.h,
                        //   width: 51.h,
                        //   //margin: EdgeInsets.only(top: 6.h)
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.local_shipping_outlined,
                                  size: 25.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Shipping information",
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TrackOrderScreen(status: 2),
                                    ),
                                  ),
                                  child: Text(
                                    "See",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                              ],
                            ),
                          ]),
                      Row(children: [
                        SizedBox(
                          width: 60.w,
                        ),
                        Text(
                          "Shipping fast EXPress TDFT",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                      ]),
                      //SizedBox(height: 20),
                    ],
                  ),

                  SizedBox(height: 20.h),
                  Container(
                    height: 2, // Chiều cao của đường thẳng
                    color: Colors.black12, // Màu sắc của đường thẳng
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Delivery address",
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ],
                            ),

                            // Row(
                            //   children: [
                            //     Text("COPY", style: TextStyle(fontSize: 20,
                            //     color: Colors.blue,

                            //     ),),
                            //      SizedBox(width: 10,),
                            //   ],
                            // ),
                          ]),
                      Row(
                        children: [
                          SizedBox(
                            width: 60.w,
                          ),
                          Text(
                            "Jone",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 60.w,
                          ),
                          Text(
                            "0123569999",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 60.w,
                          ),
                          Text(
                            "NewYork",
                            style: TextStyle(fontSize: 14.w),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  //_buildFrame5(context),
                  Container(
                    height: 1, // Chiều cao của đường thẳng
                    color: Colors.black12, // Màu sắc của đường thẳng
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListorderItem(listOrderingProduct: list),
                  SizedBox(height: 20.h),
                  //_buildFrame5(context),
                  Container(
                    height: 2, // Chiều cao của đường thẳng
                    color: Colors.black12, // Màu sắc của đường thẳng
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.payment_outlined,
                                  size: 30.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Payment method",
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ],
                            ),

                            // Row(
                            //   children: [
                            //     Text("COPY", style: TextStyle(fontSize: 20,
                            //     color: Colors.blue,

                            //     ),),
                            //      SizedBox(width: 10,),
                            //   ],
                            // ),
                          ]),
                      Row(children: [
                        SizedBox(
                          width: 60.w,
                        ),
                        Text(
                          "Cash",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  //_buildFrame5(context),
                  Container(
                    height: 2, // Chiều cao của đường thẳng
                    color: Colors.black12, // Màu sắc của đường thẳng
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "OrderID",
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              Text(
                                "Time order",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black38),
                              ),
                              // Text(
                              //   "Delivery time",
                              //   style: TextStyle(
                              //       fontSize: 18.sp, color: Colors.black38),
                              // ),
                              // Text("Voucher",style: TextStyle(fontSize: 18,color: Colors.black38),),
                              // Text("Total ",style: TextStyle(fontSize: 18),),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //SizedBox(width: 10,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "1323",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                "11-11-2023",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.black38),
                              ),
                              // Text(
                              //   "16-11-2023",
                              //   style: TextStyle(
                              //       fontSize: 18.sp, color: Colors.black38),
                              // ),
                              // Text("-23.000",style: TextStyle(fontSize: 18,color: Colors.black38),),
                              // Text("23.000.000",style: TextStyle(fontSize: 18),),
                            ],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  //_buildFrame5(context),
                  Container(
                    height: 2, // Chiều cao của đường thẳng
                    color: Colors.black12, // Màu sắc của đường thẳng
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
