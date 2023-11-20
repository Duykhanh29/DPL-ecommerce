import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_rating_bar.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/checkout_page.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Track order",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,

        //leading: Icon(Icons.menu),
      ),
      body: Column(
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
    );
  }
}
