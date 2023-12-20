import 'dart:developer';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter/material.dart';
// import 'package:timelines/timelines.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_rating_bar.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:timeline_list/timeline.dart';

class TrackOrderScreen extends StatelessWidget {
  TrackOrderScreen({Key? key, required this.status}) : super(key: key);
  int status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          LangText(context: context).getLocal()!.track_orders,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,

        //leading: Icon(Icons.menu),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Timeline(position: TimelinePosition.Left, children: [
          TimelineModel(
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Container(
                  width: 150.w,
                  // decoration: BoxDecoration(color: Colors.red),
                  height: 100,
                  child: Center(
                      child: Text(
                          LangText(context: context).getLocal()!.processing)),
                ),
              ),
              // isFirst: true,
              iconBackground: status < 1 ? Colors.grey : Colors.blue),
          TimelineModel(
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Container(
                  width: 150.w,
                  // decoration: BoxDecoration(color: Colors.red),
                  height: 100,
                  child: Center(
                    child: Text(
                        LangText(context: context).getLocal()!.confirmed_ucf),
                  ),
                ),
              ),
              iconBackground: status < 2 ? Colors.grey : Colors.blue),
          TimelineModel(
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Container(
                  width: 150.w,
                  // decoration: BoxDecoration(color: Colors.red),
                  height: 100,
                  child: Center(
                    child:
                        Text(LangText(context: context).getLocal()!.delivering),
                  ),
                ),
              ),
              iconBackground: status < 3 ? Colors.grey : Colors.blue),
          TimelineModel(
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Container(
                  width: 150.w,
                  // decoration: BoxDecoration(color: Colors.red),
                  height: 100,
                  child: Center(
                    child: Text(
                        LangText(context: context).getLocal()!.delivered_ucf),
                  ),
                ),
              ),
              position: TimelineItemPosition.left,
              isLast: true,
              iconBackground: status < 4 ? Colors.grey : Colors.blue),
        ]),
      ),

      /*
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          TimelineTile(
            contents: Card(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Text('contents'),
              ),
            ),
            node: TimelineNode(
              indicator: DotIndicator(
                size: 40,
              ),
              startConnector: SolidLineConnector(),
              endConnector: SolidLineConnector(),
            ),
          ),
          SizedBox(
            height: 50.0,
            child: SolidLineConnector(),
          ),
          TimelineTile(
            contents: Card(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Text('contents'),
              ),
            ),
            node: TimelineNode(
              indicator: DotIndicator(size: 40),
              startConnector: SolidLineConnector(),
              endConnector: SolidLineConnector(),
            ),
          ),
          SizedBox(
            height: 50.0,
            child: SolidLineConnector(),
          ),
          TimelineTile(
            contents: Card(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Text('contents'),
              ),
            ),
            node: TimelineNode(
              indicator: DotIndicator(size: 40),
              startConnector: SolidLineConnector(),
              endConnector: SolidLineConnector(),
            ),
          ),
          SizedBox(
            height: 50.0,
            child: SolidLineConnector(),
          ),
          DotIndicator(size: 40),
        ],
      ),
      */
    );
  }
}
