import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:lorapark_app/config/credentials.dart';
import 'package:lorapark_app/data/models/identity.dart';
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
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container(
        child: Center(
          child: Text(_authProvider.identity.username),
        )
      );
    }
  }

  Future<void> fetchIdentity() async {
    String _token = await GetIt.I.get<SecureService>().secureStorage.read(key: 'access_token');
    if (_token != null) {
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
