import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/router/application.dart';
import 'package:lorapark_app/controller/settings_controller/settings_controller.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/person_count.dart';
import 'package:lorapark_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';
import 'package:provider/provider.dart';
import 'package:lorapark_app/services/services.dart';
import 'package:lorapark_app/utils/utils.dart'
    show DisableScrollGlow, hideKeyboardOnTap;

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
  }

  @override
  Widget build(BuildContext context) {
    return hideKeyboardOnTap(
        child: MultiProvider(
          // Add all your providers here!
            providers: [
            ChangeNotifierProvider(create: (_) => GetIt.I. get <AuthService>()),
            ChangeNotifierProvider(create: (_) => SettingsController(repository: GetIt.I.get<PersonCountRepository>()), lazy: true,),
    ],
    child: MaterialApp(
    builder: (_, child) => ScrollConfiguration(
    behavior: DisableScrollGlow(),
    child: child,
    ),
    debugShowCheckedModeBanner: false,
    title: 'LoRaPark',
    theme: LoraParkTheme.themeData,
    home: Init(),
    )
    )
    );
  }
}
