import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final allChecked = CheckBoxModel(title: "All checked", value: false);

  final List<CheckBoxModel> checkBoxList = [
    CheckBoxModel(title: "CheckBox 1", value: false),
    CheckBoxModel(title: "CheckBox 2", value: false),
    CheckBoxModel(title: "CheckBox 3", value: false),
    CheckBoxModel(title: "CheckBox 4", value: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        allChecked.value = onAllChecked(allChecked);
                      });
                    },
                    leading: Checkbox(
                        value: allChecked.value,
                        onChanged: (value) {
                          setState(() {
                            allChecked.value = onAllChecked(allChecked);
                          });
                        }),
                    title: Text(
                      allChecked.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Divider(),
                  ...checkBoxList.map(
                    (item) => ListTile(
                      onTap: () {
                        setState(() {
                          item.value = onItemChecked(item);
                        });
                      },
                      leading: Checkbox(
                          value: item.value,
                          onChanged: (value) {
                            setState(() {
                              item.value = onItemChecked(item);
                            });
                          }),
                      title: Text(
                        item.title,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onAllChecked(CheckBoxModel check) {
    final newValue = !check.value;
    setState(() {
      check.value = newValue;
      checkBoxList.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemChecked(CheckBoxModel check) {
    final newValue = !check.value;
    setState(() {
      check.value = newValue;
      if (!newValue) {
        allChecked.value = false;
      } else {
        final allListChecked = checkBoxList.every((element) => element.value);
        allChecked.value = allListChecked;
      }
    });
  }
}

class CheckBoxModel {
  String title;
  bool value;
  CheckBoxModel({required this.title, this.value = false});
}
