import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPage extends StatefulWidget {
  String searhKey;
  String? categoryID;

  FilterPage({super.key, required this.searhKey, this.categoryID});
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  ProductRepo productRepo = ProductRepo();

  int _minPrice = 1;
  int _maxPrice = 1000000;
  List<String> _selectedCondition = [];
  List<String> _selectedConst = [];
  List<String> _selectedConn = [];
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          LangText(context: context).getLocal()!.filter_ucf,
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
            margin: EdgeInsets.all(16.h),
            child: ElevatedButton(
              onPressed: () async {
                // Xử lý khi nút Apply được nhấn
                final list = await productRepo.filterMixedConditions(
                    name: widget.searhKey,
                    dateTime: DateTime.now().subtract(const Duration(days: 30)),
                    maxPrice: _maxPrice,
                    minPrice: _minPrice,
                    rating: rating,
                    categoryID: widget.categoryID);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return SearchFilterScreen(
                      searchKey: widget.searhKey,
                      list: list,
                    );
                  },
                ));
              },
              child: Text(LangText(context: context).getLocal()!.apply_ucf),
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
              title:
                  Text(LangText(context: context).getLocal()!.price_range_ucf),
              subtitle: Row(
                children: [
                  Text('\$$_minPrice'),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RangeSlider(
                        min: 1,
                        max: 1000000,
                        divisions: 10,
                        values: RangeValues(1, _maxPrice.toDouble()),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _minPrice = 1;
                            _maxPrice = values.end.toInt();
                          });
                        },
                      ),
                    ),
                  ),
                  Text('\$$_maxPrice'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  LangText(context: context).getLocal()!.condition,
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
                _buildConditionButton(
                    LangText(context: context).getLocal()!.new_ucf),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton(
                    LangText(context: context).getLocal()!.newest_ucf),
                const SizedBox(
                  width: 5,
                ),
                _buildConditionButton(''),
              ],
            ),
            //SizedBox(height: 8),
            ListTile(
              title: Text(LangText(context: context).getLocal()!.rating_ucf),
              subtitle: Row(
                children: [
                  Text('0'),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RangeSlider(
                        min: 0,
                        max: 5,
                        divisions: 10,
                        values: RangeValues(0, rating),
                        onChanged: (RangeValues values) {
                          setState(() {
                            rating = values.end;
                          });
                        },
                      ),
                    ),
                  ),
                  Text('${rating.toStringAsFixed(1)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionButton(String label) {
    List<String> selectedList = [];
    Color buttonColor;
    Color textColor;

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
