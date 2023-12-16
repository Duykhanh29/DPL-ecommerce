import 'package:flutter/material.dart';


class PayHistory extends StatefulWidget {
  const PayHistory({super.key});

  @override
  State<PayHistory> createState() => __PayHistoryState();
}

class __PayHistoryState extends State<PayHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment history'),
      ),
      body: Container(
        height: 550,
        //child: SfCartesianChart(),
        ),
    );
  }
}