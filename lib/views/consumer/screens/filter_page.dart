import 'package:flutter/material.dart';

class FilterInterface extends StatefulWidget {
  @override
  _FilterInterfaceState createState() => _FilterInterfaceState();
}

class _FilterInterfaceState extends State<FilterInterface> {
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
          centerTitle: true,),
         
      body: Column(
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
          SizedBox(height: 16),
          Row(children: [
            SizedBox(width: 15,),
            Text("Condition",style: TextStyle(),
          textAlign: TextAlign.left,),
          ],),
          
          Row(
            children: [
              SizedBox(width: 10,),
              _buildConditionButton('New','Condition'),
              SizedBox(width: 5,),
              _buildConditionButton('Used','Condition'),
              SizedBox(width: 5,),
              _buildConditionButton('Not Specified','Condition'),
            ],
          ),
          //SizedBox(height: 8),
          Row(
            children: [
              SizedBox(width: 10,),
              _buildConditionButton('Node','Condition'),
              SizedBox(width: 130,),
            ],
          ),
          SizedBox(height: 8),
          Row(children: [
            SizedBox(width: 15,),
            Text("Condition",style: TextStyle(),
          textAlign: TextAlign.left,),
          ],),
          Row(
            children: [
              SizedBox(width: 10,),
              _buildConditionButton('New', 'Const'),
              SizedBox(width: 5,),
              _buildConditionButton('Us', 'Const'),
              SizedBox(width: 5,),
              _buildConditionButton('No Spect', 'Const'),
              
              
            ],
          ),
           Row(
            children: [
              SizedBox(width: 10,),
              _buildConditionButton('Node','Const'),
              SizedBox(width: 5,),
              _buildConditionButton('No','Const'),
              
            ],
          ),
          SizedBox(height: 8),
          Row(children: [
            SizedBox(width: 15,),
            Text("Condition",style: TextStyle(),
          textAlign: TextAlign.left,),
          ],),
          
          Row(
            children: [
              SizedBox(width: 10,),
              _buildConditionButton('Nw', 'Conn'),
              SizedBox(width: 5,),
              _buildConditionButton('Sen', 'Conn'),
              SizedBox(width: 5,),
              _buildConditionButton('Not Sped', 'Conn'),
              SizedBox(width: 5,),
              _buildConditionButton('Ne', 'Conn'),
            ],
          ),
          Row(children: [
            SizedBox(width: 15,),
            Text("Condition",style: TextStyle(),
          textAlign: TextAlign.left,),
          ],),
          Row(
            children: [
              SizedBox(width: 10,),
              _buildConditionButton('New', 'Const'),
              SizedBox(width: 5,),
              _buildConditionButton('Us', 'Const'),
              SizedBox(width: 5,),
              _buildConditionButton('No Spect', 'Const'),
              
              
            ],
          ),
           Row(
            children: [
              SizedBox(width: 10,),
              _buildConditionButton('Node','Const'),
              SizedBox(width: 5,),
              _buildConditionButton('No','Const'),
              
            ],
          ),
           Row(
            children: [
              SizedBox(width: 10,),
              _buildConditionButton('Node','Const'),
              SizedBox(width: 5,),
              _buildConditionButton('No','Const'),
              
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10,),
              _buildConditionButton('New', 'Const'),
              SizedBox(width: 5,),
              _buildConditionButton('Us', 'Const'),
              SizedBox(width: 5,),
              _buildConditionButton('No Spect', 'Const'),
              
              
            ],
          ),
          
          Spacer(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Xử lý khi nút Apply được nhấn
              },
              child: Text('Apply'),
            ),
          ),
        ],
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

