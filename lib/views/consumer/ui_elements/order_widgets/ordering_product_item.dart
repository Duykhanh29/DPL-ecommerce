import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderingProductItem extends StatelessWidget {
  const OrderingProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    children: [
                      Image.network(
                        'https://picsum.photos/250?image=9',
                        width: 80.h,
                        height: 80.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MacBook M1",
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      Text(
                        "Quality",
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      Text(
                        " ",
                        style: TextStyle(fontSize: 20.sp),
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
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  Text(
                    "x1",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Text(
                    "",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  Text(
                    "23.000.000",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              ),
              SizedBox(
                width: 10.w,
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
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total amount",
                      style: TextStyle(fontSize: 18.sp, color: Colors.black38),
                    ),
                    Text(
                      "Shipping",
                      style: TextStyle(fontSize: 18.sp, color: Colors.black38),
                    ),
                    Text(
                      "Voucher",
                      style: TextStyle(fontSize: 18.sp, color: Colors.black38),
                    ),
                    Text(
                      "Total ",
                      style: TextStyle(fontSize: 18.sp),
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
                      style: TextStyle(fontSize: 18.sp, color: Colors.black38),
                    ),
                    Text(
                      "23.000",
                      style: TextStyle(fontSize: 18.sp, color: Colors.black38),
                    ),
                    Text(
                      "-23.000",
                      style: TextStyle(fontSize: 18.sp, color: Colors.black38),
                    ),
                    Text(
                      "23.000.000",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
