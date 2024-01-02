import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar(
      {super.key,
      this.iconAction2,
      this.iconAction1,
      this.iconAction3,
      this.leadingIcon,
      this.title,
      this.functionAction1,
      this.functionAction2,
      this.functionAction3,
      this.functionLeading,
      this.isTitleCentre,
      this.backgroundColor});
  final String? title;
  final Icon? iconAction1;
  final Icon? iconAction2;
  final Icon? iconAction3;
  final Icon? leadingIcon;
  final bool? isTitleCentre;
  final Function? functionAction1;
  final Function? functionAction2;
  final Function? functionAction3;
  final Function? functionLeading;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: isTitleCentre,
      leading: IconButton(onPressed: () => functionLeading, icon: leadingIcon!),
      title: Text(title ?? ""),
      actions: [
        InkWell(
          onTap: () => functionAction1!,
          child: iconAction1,
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () => functionAction2!,
          child: iconAction2,
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () => functionAction3!,
          child: iconAction3,
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
