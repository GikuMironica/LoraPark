import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/screens.dart';
import 'package:lorapark_app/screens/sensor_list_page/sensor_list_page.dart';
import 'package:lorapark_app/screens/widgets/lp_nav_bar/lp_nav_bar.dart';
import 'package:lorapark_app/screens/widgets/lp_nav_bar/lp_nav_bar_item.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersistentTabController _tabController;

  @override
  void initState() {
    _tabController = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _tabController,
      screens: _buildScreens(),
      itemCount: _navBarItems().length,
      confineInSafeArea: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      customWidget: LPNavBar(
        items: _navBarItems(),
        onItemSelected: (idx) => setState(() => _tabController.index = idx),
        selectedIndex: _tabController.index,
      ),
      navBarStyle: NavBarStyle.custom,
    );
  }

  List<Widget> _buildScreens() {
    return [
      MapPage(),
      SensorListPage(),
      SettingsPage(),
    ];
  }

  List<LPNavBarItem> _navBarItems() {
    return [
      LPNavBarItem(
        iconName: 'map-outline',
        title: 'Map'
      ),
      LPNavBarItem(
        iconName: 'radio-outline',
        title: 'Sensoren'
      ),
      LPNavBarItem(
        iconName: 'ellipsis-horizontal-outline',
        title: 'More'
      )
    ];
  }
}
