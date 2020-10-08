import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/credentials.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/identity.dart';
import 'package:lorapark_app/screens/screens.dart';
import 'package:lorapark_app/screens/widgets/logo/lorapark_logo.dart';
import 'package:lorapark_app/services/services.dart';
import 'package:provider/provider.dart';

class Init extends StatefulWidget {
  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  void initState() {
    fetchIdentity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _authProvider = Provider.of<AuthService>(context);
    if(_authProvider.authState != AuthState.LOGGED_IN){
      return Container(
        child: Center(
          child: LoraParkLogo(size: 36,),
        ),
      );
    } else {
      return HomePage();
    }
  }

  Future<void> fetchIdentity() async {
    String _token = await GetIt.I.get<SecureService>().secureStorage.read(key: 'access_token');
    if (_token != null) {
      print('Token found in storage');
      GetIt.I.get<DioService>().setBearerToken(_token);
      Identity identity = Identity.fromJWT(_token);
      GetIt.I.get<AuthService>().setIdentity(identity);
      GetIt.I.get<AuthService>().setAuthState(AuthState.LOGGED_IN);
    } else {
      GetIt.I.get<AuthService>().setAuthState(AuthState.LOGGED_OUT);
      await GetIt.I
          .get<AuthService>()
          .login(credentials['username'], credentials['password']);
    }
  }
}
