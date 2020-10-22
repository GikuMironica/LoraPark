import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/widgets/charts/chart_legend.dart';
import 'package:lorapark_app/screens/widgets/charts/temperature_day_data.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';

import 'air_quality_day_data.dart';

class WeeklyAirQualityBarChart extends StatelessWidget {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);
  final List<AirQualityDayData> airQualityDayData;
  final double height;
  final double width;

  WeeklyAirQualityBarChart({
    @required this.airQualityDayData,
    @required this.height,
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataPresenter(
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
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
                            getTextStyles: (value) => const TextStyle(
                                color: Colors.black, fontSize: 12),
                            margin: 10,
                            getTitles: (double value) {
                              switch (value.toInt()) {
                                // case 6:
                                //   return airQualityDayData[6].dateTime;
                                case 5:
                                  return airQualityDayData[5].dateTime;
                                case 4:
                                  return airQualityDayData[4].dateTime;
                                case 3:
                                  return airQualityDayData[3].dateTime;
                                case 2:
                                  return airQualityDayData[2].dateTime;
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
                            getTextStyles: (value) => const TextStyle(
                                color: Colors.black, fontSize: 12),
                            margin: 15,
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          checkToShowHorizontalLine: (value) => value % 10 == 0,
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
            ),
            Column(children: [
              ChartLegend(
                color: dark,
                text: "NO2 Concentration",
                isSquare: false,
              ),
              ChartLegend(
                color: light,
                text: "NO Concentration",
                isSquare: false,
              ),
              ChartLegend(
                color: normal,
                text: "CO Concentration",
                isSquare: false,
              )
            ])
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> getData() {
    return [
      // BarChartGroupData(
      //   x: 6,
      //   barsSpace: 0,
      //   barRods: [
      //     BarChartRodData(
      //         y: airQualityDayData[6].noconcentration,
      //         colors: [light],
      //         borderRadius: const BorderRadius.all(Radius.zero)),
      //     BarChartRodData(
      //         y: airQualityDayData[6].no2concentration,
      //         colors: [dark],
      //         borderRadius: const BorderRadius.all(Radius.zero)),
      //     BarChartRodData(
      //         y: airQualityDayData[6].coconcentration,
      //         colors: [normal],
      //         borderRadius: const BorderRadius.all(Radius.zero)),
      //   ],
      // ),
      BarChartGroupData(
        x: 5,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: airQualityDayData[5].noconcentration,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[5].no2concentration,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[5].coconcentration,
              colors: [normal],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: airQualityDayData[4].noconcentration,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[4].no2concentration,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[4].coconcentration,
              colors: [normal],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: airQualityDayData[3].noconcentration,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[3].no2concentration,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[3].coconcentration,
              colors: [normal],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: airQualityDayData[2].noconcentration,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[2].no2concentration,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[2].coconcentration,
              colors: [normal],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: airQualityDayData[1].noconcentration,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[1].no2concentration,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[1].coconcentration,
              colors: [normal],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 0,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              y: airQualityDayData[0].noconcentration,
              colors: [light],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[0].no2concentration,
              colors: [dark],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: airQualityDayData[0].coconcentration,
              colors: [normal],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
    ];
  }
}
