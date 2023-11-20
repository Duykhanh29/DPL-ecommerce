import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/repositories/payment_repo.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/rate_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/track_order.dart';
import 'package:flutter/material.dart';
//import 'dart:html';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);
  
  
 
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            //backgroundColor: appTheme.gray5001,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                "Information order",
                textAlign: TextAlign.center,
              ),
              centerTitle: true,

              //leading: Icon(Icons.menu),
            ),
            body: Container(
                width: double.maxFinite,
                //padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 26.v),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(

                        //margin: EdgeInsets.symmetric(horizontal: 4.h),
                        //padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.v),
                        decoration: BoxDecoration(color: Colors.blue[400]),
                        child: Row(

                            ///mainAxisAlignment: MainAxisAlignment.,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.h, top: 3.v, bottom: 2.v),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Your order is delivered",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          //style: CustomTextStyles.titleMediumNunitoOnPrimary
                                        ),
                                        SizedBox(height: 10.v),
                                        const Text(
                                          "Rate product to get 5 points for collect.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                          textAlign: TextAlign.center,
                                          softWrap: true,

                                          maxLines: 7,
                                          //style: theme.textTheme.labelMedium
                                        ),
                                        SizedBox(height: 10.v),
                                      ])),
                              SizedBox(
                                width: 50,
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgFlag,
                                height: 51.v,
                                width: 51.h,
                                //margin: EdgeInsets.only(top: 6.v)
                              )
                            ])),
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
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.local_shipping_outlined,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Shipping information",
                                    style: TextStyle(fontSize: 20),
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
                                            TrackOrderScreen(),
                                      ),
                                    ),
                                    child: Text(
                                      "See",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ]),
                        Row(children: [
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            "Shipping fast EXPress TDFT",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ]),
                        Row(children: [
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            "Shipping fast EXPress TDFT",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ]),
                        //SizedBox(height: 20),
                      ],
                    ),

                    SizedBox(height: 20),
                    Container(
                      height: 2, // Chiều cao của đường thẳng
                      color: Colors.black12, // Màu sắc của đường thẳng
                    ),
                    const SizedBox(
                      height: 20,
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
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Delivery address",
                                    style: TextStyle(fontSize: 20),
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
                            width: 60,
                          ),
                          Text(
                            "Jone",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ]),
                        Row(children: [
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            "0123569999",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ]),
                        Row(children: [
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            "NewYork",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(height: 20),
                    //_buildFrame5(context),
                    Container(
                      height: 2, // Chiều cao của đường thẳng
                      color: Colors.black12, // Màu sắc của đường thẳng
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Image.network(
                                            'https://picsum.photos/250?image=9',
                                            width: 85,
                                            height: 85,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "MacBook M1",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            "Quality",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            "",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            " ",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  //SizedBox(width: 101,),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "x1",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "23.000.000",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total amount",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black38),
                                    ),
                                    Text(
                                      "Shipping",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black38),
                                    ),
                                    Text(
                                      "Voucher",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black38),
                                    ),
                                    Text(
                                      "Total ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    
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
                                      "23.000.000",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black38),
                                    ),
                                    Text(
                                      "23.000",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black38),
                                    ),
                                    Text(
                                      "-23.000",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black38),
                                    ),
                                    Text(
                                      "23.000.000",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
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
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.payment_outlined,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Payment method",
                                    style: TextStyle(fontSize: 20),
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
                            width: 60,
                          ),
                          Text(
                            "Cash",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(height: 20),
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
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "OrderID",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Time order",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black38),
                                ),
                                Text(
                                  "Delivery time",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black38),
                                ),
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
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "11-11-2023",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black38),
                                ),
                                Text(
                                  "16-11-2023",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black38),
                                ),
                                // Text("-23.000",style: TextStyle(fontSize: 18,color: Colors.black38),),
                                // Text("23.000.000",style: TextStyle(fontSize: 18),),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    //_buildFrame5(context),
                    Container(
                      height: 2, // Chiều cao của đường thẳng
                      color: Colors.black12, // Màu sắc của đường thẳng
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RatingScreen(),
                        ),
                      ),
                      child: Container(
                        //alignment: Alignment.bottomCenter,
                        child: Center(
                            child: Text(
                          "Rate",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8)),
                        width: 320,
                        height: 40,

                        // text: "Details",
                        // buttonTextStyle: TextStyle(color: Colors.white),

                        // onPressed: () => OrderDetailScreen(),
                      ),
                    ),

                    SizedBox(height: 20),
                  ]),
                ))));
  }
}


class ImageConstant {
  // Image folder path
  static String imagePath = 'assets/images';
  static String imgFlag = '$imagePath/img_flag.svg';
}
