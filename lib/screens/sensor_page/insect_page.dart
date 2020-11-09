import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/insect_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;
var ratController;
double clipSize = 0;

class RatPage extends StatefulWidget {
  @override
  _RatPage createState() => _RatPage();
}

class _RatPage extends State<RatPage> {
  @override
  Widget build(BuildContext context) {
    ratController = Provider.of<RatController>(
      context,
      listen: false,
    );
    ratController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => ratController.fetchData(),
      child: SingleSensorViewTemplate(
        scrollController: ratController.scrollController,
        clipSize: clipSize,
        sensorName: "Rat sensor",
        sensorNumber: "xx",
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Consumer<RatController>(
                    builder: (context, controller, _) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ratController.data == null 
                                ? LoadingDataPresenter()
                                : DataPresenter(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                250) /
                                            4,
                                    title: "Number of rat visits",
                                    visualization: Image(
                                      image:
                                          AssetImage("assets/images/rat.png"),
                                      height: 200,
                                      width: 200,
                                    ),
                                    data: ratController.data == null
                                        ? Text(
                                            '0 visits',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            ratController.ratVisits[ratController.ratVisits.length-1].y
                                                    .toString() +
                                                " " +
                                                "rat visits",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                            SizedBox(height: pageOffset / 2),

                            SensorDescription(
                                text:
                                    "Mit der ToxProtect bleiben sowohl der Köder als auch das Gift in einer sicheren Box. Die derzeitige Situation wird mit Lichtschranken kontinuierlich überwacht und via LoRaWAN übertragen. Um Ratten anzulocken werden Lockköder eingesetzt, welche die Zahl der täglichen Besuche steigert. Nach einigen Tagen, in denen die Box regelmäßig von Ratten besucht wird, folgt dann der Wechsel zum Giftköder. Nach Wirkung des Gifts, geht die Anzahl an Ratten stetig zurück. Alles wird in Echtzeit überwacht und kann bei Bedarf angepasst werden.",
                                image: AssetImage(
                                    "assets/images/rat_sensor.png"))

                                    
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
      clipSize = (ratController.scrollController.offset / 2);
    });
  }
}
