import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kid_good_good/kid/kid.dart';

class MonthlyHistoryLineChart extends StatelessWidget {
  MonthlyHistoryLineChart({
    required this.kid,
    int? year,
    Key? key,
  })  : this.year = year ?? DateTime.now().year,
        super(key: key);

  final Kid kid;
  final int year;

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    final Map<int, int> values = {};
    final history = kid.pointHistory;

    history.removeWhere((element) => element.dateTime.year != year);
    history.forEach((element) {
      values.putIfAbsent(element.dateTime.month, () => 0);
      values[element.dateTime.month] =
          values[element.dateTime.month]! + element.points;
    });
    history.sort();

    final textStyle = const TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    final lineChart = LineChart(
      LineChartData(
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          topTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            margin: 8,
            interval: 1,
            getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'Jan';
                case 2:
                  return 'Feb';
                case 3:
                  return 'Mar';
                case 4:
                  return 'Apr';
                case 5:
                  return 'May';
                case 6:
                  return 'Jun';
                case 7:
                  return 'Jul';
                case 8:
                  return 'Aug';
                case 9:
                  return 'Sep';
                case 10:
                  return 'Oct';
                case 11:
                  return 'Nov';
                case 12:
                  return 'Dec';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            interval: 100,
            getTextStyles: (context, value) => textStyle,
            reservedSize: 22,
            margin: 20,
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          checkToShowHorizontalLine: (double value) {
            return value % 20 == 0;
          },
        ),
        //backgroundColor: Theme.of(context).colorScheme.background,
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
            spots: values.entries.map((element) {
              return FlSpot(element.key.toDouble(), element.value.toDouble());
            }).toList(),
            belowBarData: BarAreaData(
              show: true,
              colors: [Colors.deepPurple.withOpacity(0.4)],
            ),
          ),
        ],
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );

    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: Color(0xff232d37),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text("$year Monthly Points",
                  style: textStyle.copyWith(fontSize: 22)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 24.0, left: 12.0, top: 24, bottom: 12),
                child: lineChart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
