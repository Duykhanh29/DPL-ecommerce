import 'package:dpl_ecommerce/models/daily_revenue.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MChart extends StatefulWidget {
  const MChart({super.key});

  @override
  State<MChart> createState() => _MChartState();
}

class _MChartState extends State<MChart> {
  List<DailyRevenue> chartList = [];

  List<ChartSeries> _createSampleData() {
    final data = List.generate(chartList.length, (index) {
      return OrdinalSales(
          DateFormat('dd/MM/yyyy').format(chartList[index].date!),
          int.parse(chartList[index].revenue!.round().toString())
          // 56
          );
    });

    return [
      StackedColumnSeries<OrdinalSales, String>(
          // enableTooltip: isTooltipVisible,
          dataSource: data,
          xValueMapper: (OrdinalSales sales, da) => sales.date,
          yValueMapper: (OrdinalSales sales, index) {
            return sales.sales;
          },
          isVisibleInLegend: false,
          color: Colors.grey,
          enableTooltip: true
          //enableAnimation: false,
          // markerSettings: const MarkerSettings(
          //     isVisible: true,
          //     height:  4,
          //     width:  4,
          //     shape: DataMarkerType.circle,
          //     borderWidth: 3,
          //     borderColor: Colors.red),
          // dataLabelSettings: DataLabelSettings(
          //     isVisible: true,
          //     //position: ChartDataLabelAlignment.Auto
          // ),
          ),
    ];
  }

  getChart() async {
    var response = await ShopRepo().listRevenue;
    chartList.addAll(response);
    setState(() {});
  }

  @override
  void initState() {
    getChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      //title: ChartTitle(text: 'Flutter Chart'),
      legend: Legend(isVisible: true),
      series: _createSampleData(),
      // tooltipBehavior: _tooltipBehavior,
    ));
  }
}

class OrdinalSales {
  final String? date;
  final int sales;

  OrdinalSales(this.date, this.sales);
}
