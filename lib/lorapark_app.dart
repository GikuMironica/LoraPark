import 'package:lorapark_app/config/router/application.dart';
import 'package:lorapark_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';
import 'package:provider/provider.dart';
import 'package:lorapark_app/utils/utils.dart'
    show DisableScrollGlow, hideKeyboardWrapper;
import 'config/router/routes.dart';
import 'provider_list.dart';

class LoRaParkApp extends StatefulWidget {
  @override
  _LoRaParkAppState createState() => _LoRaParkAppState();
}

class _LoRaParkAppState extends State<LoRaParkApp> {
  FluroRouter router;

  @override
  void initState() {
    super.initState();
    router = FluroRouter();
    Application.router = router;
    Application.navigatorKey = GlobalKey<NavigatorState>();
    Routes.configureRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return hideKeyboardWrapper(
        child: MultiProvider(
            providers: providerList,
            child: MaterialApp(
              builder: (_, child) => ScrollConfiguration(
                behavior: DisableScrollGlow(),
                child: child,
              ),
              debugShowCheckedModeBanner: false,
              title: 'LoRaPark',
              theme: LoraParkTheme.themeData,
              home: Init(),
            )));
  }
}
