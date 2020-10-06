import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/router/application.dart';
import 'package:lorapark_app/screens/screens.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:lorapark_app/services/services.dart';

class LoRaParkApp extends StatefulWidget {
  @override
  _LoRaParkAppState createState() => _LoRaParkAppState();
}

class _LoRaParkAppState extends State<LoRaParkApp> {
  Router router;

  @override
  void initState() {
    super.initState();
    router = Router();
    Application.router = router;
    Application.navigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return hideKeyboardOnTap(
        child: MultiProvider(
            // Add all your providers here!
            providers: [
          ChangeNotifierProvider(
            create: (_) => GetIt.I.get<AuthService>(),
          ),
        ],
            child: MaterialApp(
              title: 'LoRaPark',
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: Init(),
            )));
  }

  // This is a wrapper widget so that we can dismiss the keyboard when we tap
  // away from it.
  GestureDetector hideKeyboardOnTap({Widget child}) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: child,
    );
  }
}
