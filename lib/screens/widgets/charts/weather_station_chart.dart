import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/weather_station_controller/weather_station_controller.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:lorapark_app/data/repositories/sensor_repository/weather_station.dart';
import 'package:lorapark_app/config/sensor_list.dart';

class WeatherStationChart extends StatefulWidget {
  @override
  WeatherStationChartState createState() => WeatherStationChartState();
}

class WeatherStationChartState extends State<WeatherStationChart> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
            colors: [
              Color(0xff0f2027),
              Color(0xff203a43),
              Color(0xff2c5364),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                const Text(
                  'Weather Station 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      left: 6.0,
                    ),
                    child: LineChart(
                      isShowingMainData ? sampleData1() : sampleData2(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (_) {
          return FlLine(
            color: Colors.grey.withOpacity(0.7),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (_) {
          return FlLine(
            color: Colors.grey.withOpacity(0.7),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            return getTemperatureTitle(value.toInt());
          },
          margin: 8,
          reservedSize: 30,
        ),
        rightTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            return getHumidityTitle(value.toInt());
          },
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.7),
            width: 1,
          ),
          left: BorderSide(
            color: Colors.grey.withOpacity(0.7),
            width: 0,
          ),
          right: BorderSide(
            color: Colors.grey.withOpacity(0.7),
            width: 0,
          ),
          top: BorderSide(
            color: Colors.grey.withOpacity(0.7),
            width: 0,
          ),
        ),
      ),
      minX: 0,
      maxX: 13,
      maxY: 4,
      minY: 0,
      lineBarsData: [
        temperatureBarData(),
        humidityBarData(),
      ],
    );
  }

  LineChartBarData temperatureBarData() {
    return LineChartBarData(
      barWidth: 2,
      isCurved: true,
      isStrokeCapRound: true,
      colors: [
        const Color(0xff4af699),
      ],
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: [
          const Color(0xff4af699).withOpacity(0.3),
        ],
      ),
      spots: [
        FlSpot(0, 1),
        FlSpot(1, 1.3),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
    );
  }

  LineChartBarData humidityBarData() {
    return LineChartBarData(
      barWidth: 2,
      isCurved: true,
      isStrokeCapRound: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: [
          const Color(0xffaa4cfc).withOpacity(0.3),
        ],
      ),
      spots: [
        FlSpot(0, 1),
        FlSpot(1, 2.0),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
    );
  }

  String getTemperatureTitle(int value) {
    final weatherStationController =
        Provider.of<WeatherStationController>(context, listen: false);

    int minTemperature = weatherStationController.minTemperature.floor();
    int maxTemperature = (weatherStationController.maxTemperature + 1).floor();

    bool isAdd = false;

    while ((maxTemperature - minTemperature) % 3 != 0) {
      isAdd ? maxTemperature += 1 : minTemperature -= 1;
      isAdd = !isAdd;
    }

    int distance = maxTemperature - minTemperature;

    switch (value) {
      case 1:
        return minTemperature.toString() + ' °C';
      case 2:
        return (minTemperature + (distance ~/ 3)).toString() + ' °C';
      case 3:
        return (maxTemperature - (distance ~/ 3)).toString() + ' °C';
      case 4:
        return maxTemperature.toString() + ' °C';
      default:
        return '';
    }
  }

  String getHumidityTitle(int value) {
    final weatherStationController =
        Provider.of<WeatherStationController>(context, listen: false);

    int minHumidity = weatherStationController.minHumidity;
    int maxHumidity = weatherStationController.maxHumidity;

    bool isAdd = false;

    while ((maxHumidity - minHumidity) % 3 != 0) {
      isAdd ? maxHumidity += 1 : minHumidity -= 1;
      isAdd = !isAdd;
    }

    int distance = maxHumidity - minHumidity;

    switch (value) {
      case 1:
        return minHumidity.toString() + '%';
      case 2:
        return (minHumidity + (distance ~/ 3)).toString() + '%';
      case 3:
        return (maxHumidity - (distance ~/ 3)).toString() + '%';
      case 4:
        return maxHumidity.toString() + '%';
      default:
        return '';
    }
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
    ];
  }
}
