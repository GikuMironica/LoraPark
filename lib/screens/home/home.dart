import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/screens.dart';
import 'package:lorapark_app/screens/widgets/icons/glyphter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersistentTabController _tabController;
  final Radius radius = Radius.circular(15);

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
      items: _navBarItems(),
      confineInSafeArea: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(topRight: radius, topLeft:  radius),
        colorBehindNavBar: Colors.transparent,
      ),
      navBarStyle: NavBarStyle.style11,
    );
  }

  List<Widget> _buildScreens() {
    return [
      MapPage(),
      SettingsPage(),
      SettingsPage(),
      SettingsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Glyphter.map_outline),
        inactiveColor: Colors.grey,
        activeContentColor: Colors.tealAccent,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Glyphter.radio_outline),
        inactiveColor: Colors.grey,
        activeContentColor: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Glyphter.bar_chart_outline,),
        inactiveColor: Colors.grey,
        activeContentColor: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Glyphter.settings_outline),
        inactiveColor: Colors.grey,
        activeContentColor: Colors.black,
      )
    ];
  }
}
