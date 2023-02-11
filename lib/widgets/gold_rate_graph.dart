import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/utils/app_constants.dart';

class GoldRateGraph extends StatelessWidget {
  const GoldRateGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 60),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 120,
                minY: 0,
                maxY: 6,
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: text150,
                    );
                  },
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(2.6, 2),
                      FlSpot(4.9, 5),
                      FlSpot(6.8, 2.5),
                      FlSpot(8, 4),
                      FlSpot(9.5, 3),
                      FlSpot(11, 4),
                      FlSpot(12, 3),
                      FlSpot(26, 2),
                      FlSpot(49, 5),
                      FlSpot(68, 2.5),
                      FlSpot(80, 4),
                      FlSpot(95, 3),
                      FlSpot(110, 4),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
