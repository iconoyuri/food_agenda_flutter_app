import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcDrawer extends StatefulWidget {
  const ImcDrawer({super.key, required this.imc});

  final double imc;

  @override
  State<ImcDrawer> createState() => _ImcDrawerState();
}

class _ImcDrawerState extends State<ImcDrawer> {
  String imcStatus = "";
  Color textColor = Colors.purple.shade600;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    determineIMCstatus();
  }

  void determineIMCstatus() {
    double imc = widget.imc;
    String status;
    Color _textColor;
    if (imc <= 18.5) {
      status = "Lean";
      _textColor = Colors.purple.shade600;
    } else if (imc <= 25.9) {
      status = "Normal";
      _textColor = Colors.greenAccent.shade400;
    } else if (imc <= 29.9) {
      status = "Overweight";
      _textColor = Colors.deepOrangeAccent;
    } else {
      status = "Obesity";
      _textColor = Colors.pinkAccent;
    }
    setState(() {
      imcStatus = status;
      textColor = _textColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    determineIMCstatus();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "IMC",
            style: TextStyle(
                fontFamily: 'QanelasSoft',
                fontWeight: FontWeight.bold,
                fontSize: 40),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                    showLabels: false,
                    minimum: 0,
                    maximum: 40,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0,
                          endValue: 18.5,
                          color: Colors.purple.shade600,
                          startWidth: 40,
                          endWidth: 40),
                      GaugeRange(
                          startValue: 18.5,
                          endValue: 25.9,
                          color: Colors.greenAccent.shade400,
                          startWidth: 40,
                          endWidth: 40),
                      GaugeRange(
                          startValue: 25.9,
                          endValue: 29.9,
                          color: Colors.deepOrangeAccent,
                          startWidth: 40,
                          endWidth: 40),
                      GaugeRange(
                          startValue: 29.9,
                          endValue: 40,
                          color: Colors.pinkAccent,
                          startWidth: 40,
                          endWidth: 40),
                    ],
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        value: widget.imc,
                        markerType: MarkerType.triangle,
                        markerHeight: 30,
                        markerWidth: 30,
                        markerOffset: 30,
                        color: Colors.white,
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        axisValue: widget.imc,
                        positionFactor: 0.05,
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              widget.imc.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              imcStatus,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
