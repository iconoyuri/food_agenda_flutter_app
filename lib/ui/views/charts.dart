import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EatingHabitsChart extends StatefulWidget {
  const EatingHabitsChart(
      {super.key, required this.daysList, required this.chartTitle});

  final List<Map<String, dynamic>> daysList;
  final String chartTitle;

  @override
  State<EatingHabitsChart> createState() => _EatingHabitsChartState();
}

class _EatingHabitsChartState extends State<EatingHabitsChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // displayEatingDays();
    return SizedBox(
        width: 200,
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(
                text: widget.chartTitle, textStyle: TextStyle(fontSize: 10)),
            tooltipBehavior: _tooltipBehavior,
            series: <SplineAreaSeries<Map<String, dynamic>, String>>[
              SplineAreaSeries<Map<String, dynamic>, String>(
                dataSource: widget.daysList,
                xValueMapper: (Map<String, dynamic> data, _) => data["name"],
                yValueMapper: (Map<String, dynamic> data, _) =>
                    data["COUNT(name)"],
              )
            ]));
  }
}
