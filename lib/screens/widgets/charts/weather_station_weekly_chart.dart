import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/widgets/charts/chart_legend.dart';
import 'package:lorapark_app/screens/widgets/charts/temperature_day_data.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';

class WeeklyBarChart extends StatelessWidget {
  final Color dark = const Color(0xff3b8c75);
  final Color light = const Color(0xff73e8c9);
  final List<TemperatureDayData> temperatureDayData;
  final double height;
  final double width;

  WeeklyBarChart({
    @required this.temperatureDayData,
    @required this.height,
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return DataPresenter(
      width: width,
      height: height,
      title: "Weekly Report",
      data: Row(
        children: [
          Container(
            height: height,
            width: width,
            child: AspectRatio(
              aspectRatio: 1.66,
              child: Container(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    barTouchData: BarTouchData(
                      enabled: true,
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        rotateAngle: 25,
                        getTextStyles: (value) =>
                            const TextStyle(color: Colors.black, fontSize: 12),
                        margin: 10,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 6:
                              return temperatureDayData[6].dateTime;
                            case 5:
                              return temperatureDayData[5].dateTime;
                            case 4:
                              return temperatureDayData[4].dateTime;
                            case 3:
                              return temperatureDayData[3].dateTime;
                            case 2:
                              return temperatureDayData[2].dateTime;
                            case 1:
                              return "Yesterday";
                            case 0:
                              return "Today";
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        interval: 2,
                        getTextStyles: (value) =>
                            const TextStyle(color: Colors.black, fontSize: 12),
                        margin: 0,
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      checkToShowHorizontalLine: (value) => value % 1 == 0,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: const Color(0xffe7e8ec),
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    groupsSpace: 20,
                    barGroups: getData(),
                  ),
                ),
              ),
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ChartLegend(
              color: dark,
              text: "Night",
              isSquare: false,
            ),
            ChartLegend(
              color: light,
              text: "Day",
              isSquare: false,
            ),
          ])
        ],
      ),
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 6,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: temperatureDayData[6].dayTemp,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: temperatureDayData[6].nightTemp,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: temperatureDayData[5].dayTemp,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: temperatureDayData[5].nightTemp,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: temperatureDayData[4].dayTemp,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: temperatureDayData[4].nightTemp,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: temperatureDayData[3].dayTemp,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: temperatureDayData[3].nightTemp,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: temperatureDayData[2].dayTemp,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: temperatureDayData[2].nightTemp,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: temperatureDayData[1].dayTemp,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: temperatureDayData[1].nightTemp,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 0,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: temperatureDayData[0].dayTemp,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: temperatureDayData[0].nightTemp,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
    ];
  }
}
