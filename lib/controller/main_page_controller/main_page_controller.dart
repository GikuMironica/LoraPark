import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:lorapark_app/config/router/application.dart';
import 'package:lorapark_app/controller/ar_controller/ar_controller.dart';
import 'package:lorapark_app/screens/augmented_reality_page/augmented_reality_page.dart';
import 'package:lorapark_app/screens/map/map_page.dart';
import 'package:lorapark_app/screens/screens.dart';
import 'package:lorapark_app/screens/sensor_list_page/sensor_list_page.dart';
import 'package:lorapark_app/screens/widgets/lp_nav_bar/lp_nav_bar_item.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
class MainPageController extends ChangeNotifier{
  final PersistentTabController _tabController;
  final BuildContext _pageContext;

  bool buildUnity = false;
  BuildContext get pageContext => _pageContext;
  PersistentTabController get tabController => _tabController;

  void changePageWithRoute(String route){
    Application.router.navigateTo(_pageContext, route, transition: TransitionType.cupertino);
  }

  final List<Widget> _pages = <Widget>[
    MapPage(),
    SensorListPage(),
    AugmentedRealityPage(),
    SettingsPage(),
  ];

  List<Widget> get pages => _pages;

  MainPageController(this._pageContext) : _tabController = PersistentTabController(initialIndex: 1);

  Future<void> changeTab(int index) async {
    if(_tabController.index == index){
      return;
    }
    if(_tabController.index == 2){
      _pageContext.read<ARController>().unityWidgetController.pause();
    }
    if(index == 2){
      if(buildUnity){
        _pageContext.read<ARController>().unityWidgetController.resume();
      }
      buildUnity = true;
    }
    _tabController.index = index;
    notifyListeners();
  }

  final List<LPNavBarItem> _navBarItems = [
    LPNavBarItem(
        iconName: 'map-outline',
        title: 'Map'
    ),
    LPNavBarItem(
        iconName: 'radio-outline',
        title: 'Sensors'
    ),
    LPNavBarItem(
        iconName: 'ar-outline',
        title: 'AR'
    ),
    LPNavBarItem(
        iconName: 'ellipsis-horizontal-outline',
        title: 'More'
    )
  ];

  List<LPNavBarItem> get navBarItems => _navBarItems;
}