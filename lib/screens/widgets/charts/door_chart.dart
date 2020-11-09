import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lorapark_app/controller/sensor_controller/door_controller.dart';
import 'package:provider/provider.dart';
import 'package:lorapark_app/utils/utils.dart' show getDateTime, getWeekday;

class DoorChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var doorController = Provider.of<DoorController>(context, listen: false);
    var dates = doorController.getDistinctDates();

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        gradient: LinearGradient(
          colors: [
            Color(0xffece9e6),
            Color(0xfff6f6f6),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: doorController
                  .getMaxTotalDailyNumberOfOpenings(
                      dates.map((date) => getDateTime(date)).toList())
                  .toDouble() +
              60,
          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipPadding: const EdgeInsets.all(0),
              tooltipBottomMargin: 8,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  rod.y.round().toString(),
                  TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (_) => const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              margin: 20,
              getTitles: (value) => getWeekday(
                dates.elementAt(value.toInt()),
                showToday: true,
              ),
            ),
            leftTitles: SideTitles(showTitles: false),
          ),
          borderData: FlBorderData(show: false),
          barGroups: dates
              .map(
                (date) => BarChartGroupData(
                  x: dates.indexOf(date),
                  barRods: [
                    BarChartRodData(
                      y: doorController
                          .getTotalDailyNumberOfOpenings(getDateTime(date))
                          .toDouble(),
                      colors: [
                        Color(0xff0083b0),
                        Color(0xff00b4db),
                      ],
                    )
                  ],
                  showingTooltipIndicators: [0],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
