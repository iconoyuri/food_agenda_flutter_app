import 'package:flutter/material.dart';
import 'package:itadakimasu/src/database_logic.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EatingHabitsChart extends StatefulWidget {
  const EatingHabitsChart({super.key, required this.daysList});

  final List<Map<String, dynamic>> daysList;

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
                text: 'Meals per day', textStyle: TextStyle(fontSize: 10)),
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<Map<String, dynamic>, String>>[
              LineSeries<Map<String, dynamic>, String>(
                dataSource: widget.daysList,
                xValueMapper: (Map<String, dynamic> data, _) => data["name"],
                yValueMapper: (Map<String, dynamic> data, _) =>
                    data["COUNT(name)"],
              )
            ]));
  }
}
