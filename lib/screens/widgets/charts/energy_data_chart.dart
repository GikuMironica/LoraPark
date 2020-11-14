import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lorapark_app/controller/sensor_controller/energy_data_controller.dart';
import 'package:provider/provider.dart';

class EnergyDataChart extends StatefulWidget {
  @override
  _EnergyDataChartState createState() => _EnergyDataChartState();
}

class _EnergyDataChartState extends State<EnergyDataChart> {
  bool isShowingAverage;
  List<Map<DateTime, dynamic>> weeklyFlowTemperature;
  List<Map<DateTime, dynamic>> weeklyReturnTemperature;
  List<String> weekdays;

  @override
  void initState() {
    super.initState();
    isShowingAverage = false;
  }

  @override
  Widget build(BuildContext context) {
    _updateReportData();
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          LineChart(
            _showData(),
            swapAnimationDuration: const Duration(milliseconds: 250),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isShowingAverage = !isShowingAverage;
              });
            },
            child: Text(
              'AVG.',
              style: TextStyle(
                color: isShowingAverage ? Colors.black87 : Colors.black38,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }

  LineChartData _showData() {
    return LineChartData(
      minX: 0,
      maxX: 13,
      minY: 30,
      maxY: 130,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          getTooltipItems: _getTooltipItems,
        ),
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: _isBorderValue(value.toInt())
                ? Colors.grey
                : Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (_) => const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) => _getTemperatureTitle(value.toInt()),
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (_) => const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          getTitles: (value) => _getWeekdayTitle(value.toInt()),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Colors.black54,
            width: 2,
          ),
        ),
      ),
      lineBarsData: [
        _getFlowTemperatureBarData(),
        _getReturnTemperatureBarData(),
      ],
    );
  }

  List<LineTooltipItem> _getTooltipItems(List<LineBarSpot> barSpots) {
    return barSpots
        .map(
          (barSpot) => LineTooltipItem(
            _getBarTooltipText(barSpot),
            TextStyle(
              color: barSpot.bar.colors.first,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
        .toList();
  }

  String _getBarTooltipText(LineBarSpot barSpot) {
    return (barSpot.barIndex == 0 ? 'Incoming: ' : 'Outgoing: ') +
        _getBarSpotValue(barSpot).toStringAsFixed(1) +
        ' °C';
  }

  double _getBarSpotValue(LineBarSpot barSpot) {
    return barSpot.bar.spots[barSpot.spotIndex].y;
  }

  bool _isBorderValue(int value) {
    return value >= 40 && value <= 100 && (value / 2) % 10 == 0;
  }

  String _getTemperatureTitle(int value) {
    switch (value) {
      case 40:
        return '40 °C';
      case 60:
        return '60 °C';
      case 80:
        return '80 °C';
      case 100:
        return '100 °C';
      default:
        return '';
    }
  }

  String _getWeekdayTitle(int value) {
    if (value % 2 == 0) {
      return weekdays[value ~/ 2];
    }
    return '';
  }

  LineChartBarData _getFlowTemperatureBarData() {
    return LineChartBarData(
      barWidth: 2,
      isCurved: true,
      isStrokeCapRound: true,
      colors: [
        const Color(0xff27b6fc),
      ],
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
      spots: _getFlowTemperatureSpots(),
    );
  }

  LineChartBarData _getReturnTemperatureBarData() {
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
      ),
      spots: _getReturnTemperatureSpots(),
    );
  }

  List<FlSpot> _getFlowTemperatureSpots() {
    var spotValue;
    if (isShowingAverage) {
      var controller = Provider.of<EnergyDataController>(
        context,
        listen: false,
      );
      spotValue = controller.getAverageFlowTemperature();
    }

    return weeklyFlowTemperature
        .map((e) => FlSpot(
              weeklyFlowTemperature.indexOf(e).toDouble(),
              spotValue ?? e.values.first,
            ))
        .toList();
  }

  List<FlSpot> _getReturnTemperatureSpots() {
    var spotValue;
    if (isShowingAverage) {
      var controller = Provider.of<EnergyDataController>(
        context,
        listen: false,
      );
      spotValue = controller.getAverageReturnTemperature();
    }

    return weeklyReturnTemperature
        .map((e) => FlSpot(
              weeklyReturnTemperature.indexOf(e).toDouble(),
              spotValue ?? e.values.first,
            ))
        .toList();
  }

  void _updateReportData() {
    var controller = Provider.of<EnergyDataController>(context, listen: false);
    if (weeklyFlowTemperature == null ||
        weeklyFlowTemperature.last.keys.first !=
            controller.data.first.timestamp) {
      weeklyFlowTemperature = controller.getWeeklyFlowTemperature(14);
      weeklyReturnTemperature = controller.getWeeklyReturnTemperature(14);
      weekdays = controller.getDistinctWeekdays(showToday: true);
    }
  }
}
