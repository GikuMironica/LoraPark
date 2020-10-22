import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/charts/waste_level_chart.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

import 'package:lorapark_app/controller/sensor_controller/waste_level_controller.dart';

class WasteLevelPage extends StatefulWidget {
  @override
  _WasteLevelPageState createState() => _WasteLevelPageState();
}

class _WasteLevelPageState extends State<WasteLevelPage> {
  double clipSize = 0;
  bool isInit = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      isInit = false;

      var wasteLevelController = Provider.of<WasteLevelController>(
        context,
        listen: false,
      );

      wasteLevelController.getWasteLevelDataByTime(7).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var wasteLevelController = Provider.of<WasteLevelController>(
      context,
      listen: false,
    );
    wasteLevelController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => wasteLevelController.getWasteLevelDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: wasteLevelController.scrollController,
        clipSize: clipSize,
        sensorName: 'Waste Level',
        sensorNumber: '04',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoading
                        ? LoadingDataPresenter()
                        : Consumer<WasteLevelController>(
                            builder: (context, controller, _) => DataPresenter(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 0.3,
                              title: 'Current State',
                              visualization: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.data == null
                                      ? Colors.green
                                      : Color.lerp(
                                          Colors.green,
                                          Colors.red,
                                          controller.fillRatio,
                                        ),
                                ),
                                width: 15,
                                height: 15,
                              ),
                              data: Text(
                                controller.data == null
                                    ? '0% full'
                                    : controller.filling.toString() + '% full',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 24,
                    ),
                    isLoading
                        ? LoadingDataPresenter()
                        : DataPresenter(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.5,
                            title: 'Last 7 days',
                            data: Consumer<WasteLevelController>(
                              builder: (context, controller, _) =>
                                  WasteLevelChart(
                                sectionData: [
                                  WasteLevelChartSectionData(
                                    controller.getPercentEmpty(),
                                    controller
                                            .getPercentEmpty()
                                            .toInt()
                                            .toString() +
                                        '%',
                                    Colors.green,
                                  ),
                                  WasteLevelChartSectionData(
                                    controller.getPercentFull(),
                                    controller
                                            .getPercentFull()
                                            .toInt()
                                            .toString() +
                                        '%',
                                    Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    SensorDescription(
                      text:
                          'Mit diesem Sensor kann über eine Ultra­schall­abstands­messung der Füllgrad eines Behälters bestimmt werden. Sollte der Behälter voll sein, kann automatisch eine Abholung ausgelöst werden. Dies bietet nicht nur den Vorteil, dass es zu keiner Vermüllung in der Stadt kommt, sondern es können auch unnötige Leerungen eingespart werden und die Route bei der Abholung entsprechend an den tatsächlichen Bedarf angepasst werden.',
                      image: AssetImage(
                        'assets/images/container.jpg',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    var wasteLevelController = Provider.of<WasteLevelController>(
      context,
      listen: false,
    );

    setState(() {
      clipSize = (wasteLevelController.scrollController.offset / 2);
    });
  }
}
