import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/sensors.dart';
import 'package:lorapark_app/controller/ar_controller/ar_controller.dart';
import 'package:lorapark_app/controller/main_page_controller/main_page_controller.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AugmentedRealityPage extends StatefulWidget {
  @override
  _AugmentedRealityPage createState() => _AugmentedRealityPage();
}

class _AugmentedRealityPage extends State<AugmentedRealityPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final sensorList = GetIt.I.get<Sensors>().list;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(children: <Widget>[
          Consumer<ARController>(
            builder: (_, arController, __) {
              if(context.read<MainPageController>().buildUnity){
              return UnityWidget(
                disableUnload: true,
                onUnityViewCreated: arController.onUnityCreated,
                isARScene: true,
                onUnityMessage: arController.onUnityMessage,
                onUnitySceneLoaded: arController.onUnitySceneLoaded,
                fullscreen: false,
              );
            } else {
              return SizedBox(height: 1, width: 1,);
              }
            }
          ),
          SlidingUpPanel(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            minHeight: MediaQuery.of(context).size.height * 0.07,
            maxHeight: MediaQuery.of(context).size.height / 2.5,
            panel: _panel(),
          )
        ]));
  }

  Widget _panel() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: MediaQuery.of(context).size.height * 0.025),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      height: (MediaQuery.of(context).size.height / 3),
      child: Column(
        children: [
          Text(
            'AR Navigation',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
          Text('Tap on any sensor to begin a navigation to it.'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sensorList.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                      onTap: (){
                        if (context.read<ARController>().navigationTo != index){
                          context.read<ARController>().setNavigationTo(index);
                        } else {
                          context.read<ARController>().setNavigationTo(null);
                        }
                      },
                      leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: sensorList[index].image),
                      selected: true,
                      title: Text(sensorList[index].name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),),
                      subtitle: Text(sensorList[index].number),
                      dense: false,
                      trailing: Consumer<ARController>(
                          builder: (_, arController, __){
                            if(arController.navigationTo != index){
                              return Container(
                                alignment: Alignment.center,
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Icon(
                                  Icons.navigation_outlined,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Container(
                                alignment: Alignment.center,
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Icon(
                                  Icons.cancel_outlined,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              );
                            }
                          }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
