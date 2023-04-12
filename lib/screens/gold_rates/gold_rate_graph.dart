import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/services/graph_services.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class GoldRateGraph extends StatefulWidget {
  const GoldRateGraph({super.key});

  @override
  State<GoldRateGraph> createState() => _GoldRateGraphState();
}

class _GoldRateGraphState extends State<GoldRateGraph> {
  @override
  initState() {
    super.initState();

    debugPrint('graph init state');
  }

  List<Color> gradientColors = [
    AppColors.contentColorYellow,
    AppColors.contentColorYellow,
  ];

  GraphTimeRange _graphTimeRange = GraphTimeRange.week;

  Future<ChartDataHelper?> _getChartData() async {
    try {
      if (_graphTimeRange == GraphTimeRange.week) {
        return _get1WeekData();
      } else if (_graphTimeRange == GraphTimeRange.year) {
        return _get1YearData();
      }
    } catch (e) {
      // debugPrint(e.toString());
      rethrow;
    }
    return null;
  }

  Future<ChartDataHelper?> _get1YearData() async {
    await GraphServices.get1YearData().then((graphList) {
      if (graphList != null) {
        return ChartDataHelper.fromJson(graphList: graphList);
      }
    });
    return null;
  }

  Future<ChartDataHelper?> _get1WeekData() async {
    try {
      await GraphServices.get1WeekData().then((graphList) {
        debugPrint(graphList.toString());
        if (graphList != null) {
          return ChartDataHelper.fromJson(graphList: graphList);
        }
      });
    } catch (E) {
      debugPrint(E.toString());
      rethrow;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('graph build');
    return FutureBuilder(
        future: _getChartData(),
        builder: (context, AsyncSnapshot<ChartDataHelper?> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return Center(child: Text('Something Went Wrong ${snap.error}'));
          } else if (snap.data == null) {
            return const Center(child: Text('Data is null'));
          }

          return Column(
            children: [
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                        top: 8,
                        bottom: 5,
                      ),
                      child: LineChart(
                        mainData(snap.data!),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        _graphTimeRange = GraphTimeRange.week;
                      });
                    },
                    child: Text(
                      '1W',
                      style: TextStyle(
                        color: text500,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          _graphTimeRange = GraphTimeRange.year;
                        });
                      },
                      child: Text('1Y', style: TextStyle(color: text500))),
                ],
              ),
            ],
          );
        });
  }

  LineChartData mainData(ChartDataHelper charHelperData) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: null,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: null,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: charHelperData.minX,
      maxX: charHelperData.maxX,
      minY: charHelperData.minY,
      maxY: charHelperData.maxY,
      lineBarsData: [
        LineChartBarData(
          // spots: const [
          //   FlSpot(0, 3),
          //   FlSpot(2.6, 2),
          //   FlSpot(4.9, 5),
          //   FlSpot(6.8, 3.1),
          //   FlSpot(8, 4),
          //   FlSpot(9.5, 3),
          //   FlSpot(11, 4),
          // ],
          spots: charHelperData.charFlSpotList,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 2.5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
      // TODO: SHOW TOOL TIP INDICATORS PARAMETERS
      // showingTooltipIndicators: charHelperData.showToolTipIndicators,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}

enum GraphTimeRange {
  day,
  week,
  year,
  threeYear,
  fiveYear,
}

class ChartDataHelper {
  final List<FlSpot> charFlSpotList;
  // final List<ShowingTooltipIndicators> showToolTipIndicators;
  final double minX;
  final double minY;
  final double maxX;
  final double maxY;

  ChartDataHelper({
    required this.charFlSpotList,
    // required this.showToolTipIndicators,
    required this.maxX,
    required this.maxY,
    required this.minX,
    required this.minY,
  });

  factory ChartDataHelper.fromJson({required Map<String, dynamic> graphList}) {
    double minx = 0;
    double miny = double.infinity;
    double maxx = double.minPositive;
    double maxy = double.minPositive;

    List<FlSpot> charFlSpotList = [];
    List<ShowingTooltipIndicators> showToolTipData = [];
    double x = 0;
    for (String? key in graphList.keys) {
      if (key == null) {
        continue;
      }
      double price = double.tryParse(graphList[key]['INR']) ?? 0.0;
      FlSpot spot = FlSpot(x, price);
      charFlSpotList.add(spot);

      // showToolTipData.add('$key\n${price.toStringAsFixed(4)}');

      maxx++;
      miny = min(miny, price);
      maxy = max(maxy, price);
    }

    return ChartDataHelper(
      charFlSpotList: charFlSpotList,
      // showToolTipIndicators: showToolTipData,
      maxX: maxx,
      maxY: maxy,
      minX: minx,
      minY: miny,
    );
  }
}
