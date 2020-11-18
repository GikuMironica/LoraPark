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
                            getTitles: (value) => airQualityDayData
                                .elementAt(value.toInt())
                                .dateTime,
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            interval: 40,
                            getTextStyles: (value) => const TextStyle(
                                color: Colors.black, fontSize: 12),
                            margin: 15,
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          checkToShowHorizontalLine: (value) => value % 20 == 0,
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
    return airQualityDayData
        .map(
          (dayData) => BarChartGroupData(
            x: airQualityDayData.indexOf(dayData),
            barRods: [
              BarChartRodData(
                  y: dayData.noconcentration,
                  colors: [light],
                  borderRadius: const BorderRadius.all(Radius.zero)),
              BarChartRodData(
                  y: dayData.no2concentration,
                  colors: [dark],
                  borderRadius: const BorderRadius.all(Radius.zero)),
              BarChartRodData(
                  y: dayData.coconcentration,
                  colors: [normal],
                  borderRadius: const BorderRadius.all(Radius.zero)),
            ],
          ),
        )
        .toList();
  }
}
