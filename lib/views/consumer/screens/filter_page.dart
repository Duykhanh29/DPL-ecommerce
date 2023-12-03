import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double _minPrice = 1;
  double _maxPrice = 10;
  List<String> _selectedCondition = [];
  List<String> _selectedConst = [];
  List<String> _selectedConn = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Filter",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Spacer(),
          _buildConditionBars(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Xử lý khi nút Apply được nhấn
              },
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionBars() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text('Price range'),
              subtitle: Row(
                children: [
                  Text('\$$_minPrice'),
                  Expanded(
                    child: RangeSlider(
                      min: 1,
                      max: 10,
                      divisions: 9,
                      values: RangeValues(_minPrice, _maxPrice),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _minPrice = values.start;
                          _maxPrice = values.end;
                        });
                      },
                    ),
                  ),
                  Text('\$$_maxPrice'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Condition",
                  style: TextStyle(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),

            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildConditionButton('New', 'Condition'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('Used', 'Condition'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('Not Specified', 'Condition'),
              ],
            ),
            //SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildConditionButton('Node', 'Condition'),
                const SizedBox(
                  width: 130,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Condition",
                  style: TextStyle(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildConditionButton('New', 'Const'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('Us', 'Const'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('No Spect', 'Const'),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildConditionButton('Node', 'Const'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('No', 'Const'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Condition",
                  style: TextStyle(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),

            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildConditionButton('Nw', 'Conn'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('Sen', 'Conn'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('Not Sped', 'Conn'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('Ne', 'Conn'),
              ],
            ),
            const Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Condition",
                  style: TextStyle(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildConditionButton('New', 'Const'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('Us', 'Const'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('No Spect', 'Const'),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildConditionButton('Node', 'Const'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('No', 'Const'),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildConditionButton('Node', 'Const'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('No', 'Const'),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildConditionButton('New', 'Const'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('Us', 'Const'),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton('No Spect', 'Const'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionButton(String label, String type) {
    List<String> selectedList = [];
    Color buttonColor;
    Color textColor;

    if (type == 'Condition') {
      selectedList = _selectedCondition;
    } else if (type == 'Const') {
      selectedList = _selectedConst;
    } else if (type == 'Conn') {
      selectedList = _selectedConn;
    }

    bool isSelected = selectedList.contains(label);
    buttonColor = isSelected ? Colors.blue : Colors.white;
    textColor = isSelected ? Colors.white : Colors.grey;

    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (isSelected) {
              selectedList.remove(label);
            } else {
              selectedList.add(label);
            }
          });
        },
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
        ),
        child: Text(
          label,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
