import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/person_count_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;
var personCountController;
double clipSize = 0;

class PersonCountPage extends StatefulWidget {
  @override
  _PersonCountPage createState() => _PersonCountPage();
}

class _PersonCountPage extends State<PersonCountPage> {
  @override
  Widget build(BuildContext context) {
    personCountController = Provider.of<PersonCountController>(
      context,
      listen: false,
    );
    personCountController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => personCountController.getPersonDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: personCountController.scrollController,
        clipSize: clipSize,
        sensorName: "Person Count",
        sensorNumber: "xx",
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Consumer<PersonCountController>(
                    builder: (context, controller, _) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.data == null
                                ? LoadingDataPresenter()
                                : DataPresenter(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                250) /
                                            4,
                                    title: "Number of people",
                                    visualization: Image(
                                      image:
                                          AssetImage("assets/images/group.png"),
                                      height: 200,
                                      width: 200,
                                    ),
                                    data: personCountController.data == null
                                        ? Text(
                                            '0 people',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            personCountController.paxCount
                                                    .toString() +
                                                " " +
                                                "people",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                            SizedBox(height: pageOffset / 2),
                            SensorDescription(
                                text:
                                    "Diese Beacons verwendet der Personenzähler, um eine ungefähre Anzahl an Personen ermitteln zu können. Das geschieht anonym und ohne Identifizierung der Person selbst.",
                                image: AssetImage(
                                    "assets/images/person_count.png"))
                          ],
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    setState(() {
      clipSize = (personCountController.scrollController.offset / 2);
    });
  }
}
