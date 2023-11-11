// import 'package:flutter/material.dart';

// class CustomradioButton extends StatefulWidget {
//   CustomradioButton({super.key, required this.list});
//   List<String>? list;
//   @override
//   State<CustomradioButton> createState() => _CustomradioButtonState();
// }

// class _CustomradioButtonState extends State<CustomradioButton> {
//   int selectedIndex = 0;

//   void changeIndex(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       child: ListView.builder(
//         physics: BouncingScrollPhysics(),
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return customRadio(index, widget.list![index]);
//         },
//         itemCount: widget.list!.length,
//       ),
//     );
//   }

//   Widget customRadio(int index, String text) {
//     return OutlinedButton(
//         onPressed: () {
//           changeIndex(index);
//         },
//         style: ButtonStyle(
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(
//                   color: selectedIndex == index ? Colors.cyan : Colors.grey)),
//         )),
//         child: Text(
//           text,
//           style: TextStyle(
//               color: selectedIndex == index ? Colors.indigo : Colors.black),
//         ));
//   }
// }
