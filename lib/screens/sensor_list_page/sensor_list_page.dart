import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:lorapark_app/controller/search_controller/sensor_search_controller.dart';
import 'package:lorapark_app/screens/ocr_page/ocr_page.dart';
import 'package:lorapark_app/screens/widgets/sensor/sensor_card.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SensorListPage extends StatefulWidget {
  @override
  _SensorListPageState createState() => _SensorListPageState();
}

class _SensorListPageState extends State<SensorListPage> {
  SensorSearchController searchController;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECECEC),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: LoraParkTheme.themeData.primaryColor,
            pinned: true,
            floating: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsetsDirectional.only(
                bottom: 60,
                start: 8,
                end: 8,
              ),
              title: Consumer<SensorSearchController>(
                builder: (_, controller, __) => TextField(
                  controller: controller.textEditingController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 6,
                    ),
                    hintText: 'Search for sensors',
                    hintStyle: TextStyle(fontSize: 12),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 16,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    suffixIcon: controller.query.isEmpty
                        ? Container()
                        : IconButton(
                            icon: Icon(Icons.clear_rounded),
                            onPressed: controller.clearQuery,
                            iconSize: 16,
                          ),
                    suffixIconConstraints: BoxConstraints(
                      maxWidth: 32,
                      maxHeight: 32,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
            bottom: AppBar(
              title: Text(
                'Available Sensors',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              actions: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/svg/text-scan.svg',
                    semanticsLabel: 'Sensor Number Scanner',
                  ),
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: OcrPage(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                )
              ],
            ),
          ),
          Consumer<SensorSearchController>(
            builder: (_, controller, __) => SliverList(
              delegate: SliverChildListDelegate(
                [
                  controller.filteredSensors.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No Results',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'There were no results for "${controller.query}".',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: controller.filteredSensors.length,
                          itemBuilder: (_, index) => SensorCard(
                              sensor: controller.filteredSensors[index]),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
