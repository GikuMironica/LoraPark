// TODO: Delete this file before pushing to production.
import 'package:catcher/catcher.dart';
import 'package:lorapark_app/config/consts.dart' show WEB_HOOK;

/// This is a Crash Handler for DEVELOPMENT PURPOSES.
///
/// The output should be sent to the discord channel #crashlogs
CatcherOptions debugOptions = CatcherOptions(SilentReportMode(), [
  DiscordHandler(WEB_HOOK,
    enableDeviceParameters: true,
    enableStackTrace: true,
    printLogs: true,
  ),
]);