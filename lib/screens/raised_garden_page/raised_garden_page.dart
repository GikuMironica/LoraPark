
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/raised_garden_controller/raised_garden_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double verticalOffset = 24;
const double pageOffset = 20;
var raisedGardenController;
double clipSize = 0;

class RaisedGardenPage extends StatefulWidget {
  @override
  _RaisedGardenPage createState() => _RaisedGardenPage();
}

class _RaisedGardenPage extends State<RaisedGardenPage> {

  @override
  Widget build(BuildContext context) {
    raisedGardenController =
        Provider.of<RaisedGardenController>(context);
    raisedGardenController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => raisedGardenController.getRaisedGardennData(),
      child: SingleSensorViewTemplate(
        scrollController: raisedGardenController.scrollController,
        clipSize: clipSize,
        sensorController: raisedGardenController,
        sensorName: "Raised Garden",
        sensorNumber: "12",
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataPresenter(
                        width: MediaQuery.of(context).size.width,
                        height: (MediaQuery.of(context).size.height - 250) / 3,
                        title: "Water tank state",
                        image: const AssetImage("assets/images/water_level.png"),
                        data: raisedGardenController.data == null
                            ? 'no data'
                            : (raisedGardenController.watertankEmpty ? 'Full' : 'Empty'),
                        unit: "",
                      ),
                      SizedBox(height: verticalOffset),
                      DataPresenter(
                        width: MediaQuery.of(context).size.width,
                        height: (MediaQuery.of(context).size.height - 250) / 3,
                        title: "Humidity",
                        image: const AssetImage("assets/images/vwc.png"),
                        data: raisedGardenController.data == null
                            ? '0'
                            : raisedGardenController.humidity.toString(),
                        unit: '%',
                      ),
                      SizedBox(height: verticalOffset),
                    ]
                ),
              ),
              SizedBox(height: pageOffset),
              SensorDescription(
                text:
                  "Das autarke Hochbeet bewässert sich je nach Feuchtigkeit der Erdeim Beet selbständig und automatisch über einen integrierten Wasser-tank. Die Messung der Bodenfeuchtigkeit wird über Tensiometergeregelt, die - ähnlich wie Pflanzen selbst - über die Saugspannungden Wassergehalt im Boden bestimmen. Ist der Feuchtigkeitswertzu gering, wird die Bewässerung ausgelöst. Für die Überwachung des Beets, vor allem des Wasserstands im Tank sowie der Bodenfeuchtigkeit, werden regelmäßig Sensordatenvia LORAWAN versendet, so können zum Beispiel gemeinschaftlicheUrban Gardening-Projekte erleichtert werden.",
                image: AssetImage("assets/images/raised_garden.jpg"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    setState(() {
      clipSize = ( raisedGardenController.scrollController.offset / 2);
    });
  }
}