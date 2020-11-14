import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:lorapark_app/controller/ar_controller/ar_controller.dart';
import 'package:lorapark_app/data/models/sensor.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AugmentedRealityPage extends StatefulWidget {
  @override
  _AugmentedRealityPage createState() => _AugmentedRealityPage();
}

class _AugmentedRealityPage extends State<AugmentedRealityPage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  var dropdownValue;

  @override
  void initState() {
    super.initState();
    var arController = Provider.of<ARController>(
      context,
      listen: false,
    );
    dropdownValue = arController.sensorList.list[0];
  }

  @override
  Widget build(BuildContext context) {
    var arController = Provider.of<ARController>(
      context,
      listen: false,
    );
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(children: <Widget>[
          UnityWidget(
            onUnityViewCreated: arController.onUnityCreated,
            isARScene: true,
            onUnityMessage: arController.onUnityMessage,
            onUnitySceneLoaded: arController.onUnitySceneLoaded,
            fullscreen: false,
          ),
          SlidingUpPanel(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            minHeight: 40,
            maxHeight: MediaQuery.of(context).size.height / 2.5,
            collapsed: Container(
              child: Text(
                "AR Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            panel: _panel(),
          )
        ]));
  }

  Widget _panel() {
    var arController = Provider.of<ARController>(
      context,
    );
    return Container(
        margin: const EdgeInsets.only(top: 35),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height / 3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: arController.sensorList.list.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                        leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                arController.sensorList.list[index].image),
                        selected: true,
                        title: Text(arController.sensorList.list[index].name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),),
                        subtitle: Text(
                            "#" + arController.sensorList.list[index].number),
                        dense: false,
                        trailing: Consumer<ARController>(
                            builder: (context, controller, _) => Container(
                                  width: 35.0,
                                  height: 35.0,
                                  child: arController.navigationTo != index
                                      ? FloatingActionButton(
                                          backgroundColor: Colors.blue,
                                          child: Icon(
                                            Icons.navigation_outlined,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            arController.navigationTo = index;
                                            setState(() {});
                                            arController.navigateInUnity(
                                                arController
                                                    .sensorList.list[index]);
                                          },
                                        )
                                      : FloatingActionButton(
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            arController.navigationTo = null;
                                            setState(() {});
                                            arController.stopNavigation();
                                          },
                                        ),
                                ))),
                  ),
                ),
              ),
            ]));
  }
}
