import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'chart_legend.dart';

class WasteLevelChart extends StatelessWidget {
  final List<WasteLevelChartSectionData> sectionData;

  WasteLevelChart({
    @required this.sectionData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          PieChart(
            PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: _getSections(),
            ),
          ),
          SizedBox(
            width: 36,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChartLegend(
                color: Colors.green,
                text: 'Empty',
                isSquare: true,
              ),
              SizedBox(
                height: 10,
              ),
              ChartLegend(
                color: Colors.red,
                text: 'Full',
                isSquare: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _getSections() {
    return List.generate(sectionData.length, (index) {
      return PieChartSectionData(
        color: sectionData[index].color,
        value: sectionData[index].value,
        title: sectionData[index].title,
        radius: sectionData[index].radius,
        titleStyle: TextStyle(
          fontSize: sectionData[index].titleSize,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      );
    });
  }
}

class WasteLevelChartSectionData {
  double _value;
  String _title;
  Color _color;
  double _radius;
  double _titleSize;

  WasteLevelChartSectionData(
    value,
    title,
    color, {
    radius = 70.0,
    titleSize = 24.0,
  }) {
    _value = value;
    _title = title;
    _color = color;
    _radius = radius;
    _titleSize = titleSize;
  }

  double get value => _value;

  String get title => _title;

  Color get color => _color;

  double get radius => _radius;

  double get titleSize => _titleSize;
}
