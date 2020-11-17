import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreController extends ChangeNotifier {
  String _appVersion;
  String get appVersion => _appVersion;

  MoreController(){
    setAppVersion();
  }

  void setAppVersion() async {
    var _info = await PackageInfo.fromPlatform();
    _appVersion = _info.version;
    notifyListeners();
  }

  void launchDatenschutz() async {
    await launch('https://studium.hs-ulm.de/de/Seiten/Datenschutzerklaerung_kurz.aspx');
  }

  void launchImpressum() async {
    await launch('https://studium.hs-ulm.de/de/Seiten/Impressum.aspx');
  }

  void rateApp() {
    LaunchReview.launch();
  }

  String generateDeviceInfoMessage(
      [AndroidDeviceInfo androidDeviceInfo, IosDeviceInfo iosDeviceInfo]) {
    switch (Platform.operatingSystem) {
      case 'android':
        return 'OS: Android\nVersion: ${androidDeviceInfo.version.release} '
            '(API ${androidDeviceInfo.version.sdkInt})\n'
            'Device: ${androidDeviceInfo.brand.capitalized()} '
            '${androidDeviceInfo.model} (${androidDeviceInfo.device})\n'
            'Manufacturer: ${androidDeviceInfo.manufacturer.capitalized()}\n';
        break;
      case 'ios':
      // TODO: See how this works on iPhone.
        return 'OS: ';
        break;
      default:
        return 'OS: Unknown\n';
        break;
    }
  }

  void composeFeedback() async {
    var _deviceInfoPlugin = await DeviceInfoPlugin();
    var _deviceInfo;
    if (Platform.isIOS) {
      _deviceInfo = await _deviceInfoPlugin.iosInfo;
    } else if (Platform.isAndroid) {
      _deviceInfo = await _deviceInfoPlugin.androidInfo;
    }
    var baseEmailBody = 'Hi,\n\nI have a feedback for the LoraPark App: \n\n\n\n'
        '\n\n\n\n\n-----------\nApp Version: ${appVersion}\n'
        '${generateDeviceInfoMessage(_deviceInfo)}';

    final email = Email(body: baseEmailBody,
        recipients: ['castana@mail.hs-ulm.de'],
        subject: 'Feedback for the LoraPark App',
        isHTML: false);

    await FlutterEmailSender.send(email);
  }

  List<Widget> get listItems => <Widget>[
    ListTile(
      title: Text('Datenschutz'),
      onTap: () => launchDatenschutz(),
    ),
    ListTile(
      title: Text('Impressum'),
      onTap: () => launchImpressum(),
    ),
    ListTile(
      title: Text('Feedback'),
      onTap: () => composeFeedback(),
    ),
    ListTile(
      title: Text('Rate App'),
      onTap: () => rateApp(),
    ),
    ListTile(
      title: Text('App Version'),
      subtitle: Text('${appVersion}'),
    ),
  ];
}

extension StringExtensions on String {
  String capitalized() =>
      substring(0, 1).toUpperCase() + substring(1).toLowerCase();
}