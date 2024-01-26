import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/models/category_chart.dart';
import 'package:dpl_ecommerce/repositories/statistics_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryChartWidget extends StatefulWidget {
  const CategoryChartWidget({super.key});

  @override
  State<CategoryChartWidget> createState() => _CategoryChartWidgetState();
}

class _CategoryChartWidgetState extends State<CategoryChartWidget> {
  List<CategoryChart>? list;
  StatisticsRepo statisticsRepo = StatisticsRepo();
  bool isInit = true;
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    // TODO: implement initState
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    list = await statisticsRepo.getTotalProductOfEachCategory();
    isInit = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return isInit || isInit == null || list!.isEmpty
        ? const SizedBox()
        : Container(
            decoration: BoxDecoration(
                border: Border.all(color: MyTheme.medium_grey, width: 0.5)),
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: SfCircularChart(
              title: ChartTitle(
                  text: LangText(context: context)
                      .getLocal()!
                      .number_of_products_by_category),
              legend: const Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                // textStyle: TextStyle(
                //   fontSize: 20.sp, // Adjust the font size as needed
                // ),
              ),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<CategoryChart, String>(
                  legendIconType: LegendIconType.diamond,
                  dataSource: list,
                  xValueMapper: (CategoryChart data, _) => data.name,
                  yValueMapper: (CategoryChart data, _) => data.totalProduct,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true, textStyle: TextStyle(fontSize: 20.sp)),
                  enableTooltip: true,
                )
              ],
            ),
          );
  }
}
