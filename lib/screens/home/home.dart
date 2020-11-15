import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/main_page_controller/main_page_controller.dart';
import 'package:lorapark_app/screens/widgets/lp_nav_bar/lp_nav_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainPageController(context),
      child: Consumer<MainPageController>(
        builder: (context, controller, _) => PersistentTabView(
          controller: controller.tabController,
          screens: controller.pages,
          itemCount: controller.pages.length,
          confineInSafeArea: true,
          resizeToAvoidBottomInset: true,
          hideNavigationBarWhenKeyboardShows: true,
          backgroundColor: Colors.white,
          decoration: NavBarDecoration(
            colorBehindNavBar: Colors.white,
          ),
          customWidget: LPNavBar(
            items: controller.navBarItems,
            onItemSelected: (idx) async => await controller.changeTab(idx),
            selectedIndex: controller.tabController.index,
          ),
          navBarStyle: NavBarStyle.custom,
        ),
      ),
    );
  }
}
