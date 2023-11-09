import 'package:flutter/material.dart';

class CustomArrayBackWidget extends StatelessWidget {
  const CustomArrayBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
