import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/raised_garden_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double verticalOffset = 24;
const double pageOffset = 20;
double clipSize = 0;

class RaisedGardenPage extends StatefulWidget {
  @override
  _RaisedGardenPage createState() => _RaisedGardenPage();
}

class _RaisedGardenPage extends State<RaisedGardenPage> {
  @override
  Widget build(BuildContext context) {
    var raisedGardenController = Provider.of<RaisedGardenController>(
      context,
      listen: false,
    );
    raisedGardenController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => raisedGardenController.getRaisedGardennData(),
      child: SingleSensorViewTemplate(
        scrollController: raisedGardenController.scrollController,
        clipSize: clipSize,
        sensorName: "Raised Garden",
        sensorNumber: "12",
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Consumer<RaisedGardenController>(
                  builder: (context, controller, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        raisedGardenController.data == null
                            ? LoadingDataPresenter()
                            : DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    (MediaQuery.of(context).size.width) * 0.30,
                                title: "Water tank state",
                                visualization: Image(
                                  image: AssetImage(
                                      "assets/images/water_level.png"),
                                  height: 200,
                                  width: 200,
                                ),
                                data: Text(
                                  (raisedGardenController.watertankEmpty
                                      ? 'Empty'
                                      : 'Full'),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                        SizedBox(height: verticalOffset),
                        raisedGardenController.data == null
                            ? LoadingDataPresenter()
                            : DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    (MediaQuery.of(context).size.width) * 0.30,
                                title: "Ground Humidity",
                                visualization: Image(
                                  image: AssetImage("assets/images/vwc.png"),
                                  height: 200,
                                  width: 200,
                                ),
                                data: Text(
                                  raisedGardenController.humidity.toString() +
                                      " " +
                                      "%",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                        SizedBox(height: pageOffset),
                        SensorDescription(
                          text:
                              "Das autarke Hochbeet bewässert sich je nach Feuchtigkeit der Erdeim Beet selbständig und automatisch über einen integrierten Wasser-tank. Die Messung der Bodenfeuchtigkeit wird über Tensiometergeregelt, die - ähnlich wie Pflanzen selbst - über die Saugspannungden Wassergehalt im Boden bestimmen. Ist der Feuchtigkeitswertzu gering, wird die Bewässerung ausgelöst. Für die Überwachung des Beets, vor allem des Wasserstands im Tank sowie der Bodenfeuchtigkeit, werden regelmäßig Sensordatenvia LORAWAN versendet, so können zum Beispiel gemeinschaftlicheUrban Gardening-Projekte erleichtert werden.",
                          image: AssetImage("assets/images/raised_garden.jpg"),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    var raisedGardenController = Provider.of<RaisedGardenController>(
      context,
      listen: false,
    );
    setState(() {
      clipSize = (raisedGardenController.scrollController.offset / 2);
    });
  }
}
