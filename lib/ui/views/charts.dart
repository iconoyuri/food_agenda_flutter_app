import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:itadakimasu/src/database_logic.dart';

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
    return Expanded(
        flex: 1,
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(
                text: widget.chartTitle,
                textStyle: const TextStyle(fontSize: 10)),
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

class RadialMeansChart extends StatefulWidget {
  const RadialMeansChart(
      {super.key, required this.means, required this.chartTitle});

  final List<GDPData> means;
  final String chartTitle;

  @override
  State<RadialMeansChart> createState() => _RadialMeansChartState();
}

class _RadialMeansChartState extends State<RadialMeansChart> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: SfCircularChart(
            title: ChartTitle(
                text: widget.chartTitle,
                textStyle: const TextStyle(fontWeight: FontWeight.bold)),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              RadialBarSeries<GDPData, String>(
                  dataSource: widget.means,
                  xValueMapper: (GDPData data, _) => data.field,
                  yValueMapper: (GDPData data, _) => data.value,
                  enableTooltip: true)
            ]));
  }
}
