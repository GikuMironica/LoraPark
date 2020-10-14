import 'package:jiffy/jiffy.dart';
import 'package:logger/logger.dart';

class LoggingPrinter extends LogPrinter {
  final String className;
  final bool printTime;
  final bool colors;

  LoggingPrinter({this.className, this.colors = false, this.printTime = true});

  static final levelColors = {
    Level.debug: LogColors.debug,
    Level.error: LogColors.error,
    Level.info: LogColors.info,
    Level.warning: LogColors.warning,
    Level.wtf: LogColors.wtf,
  };


  @override
  List<String> log(LogEvent event) {
    var timestamp = Jiffy().Hms;
    var emoji = PrettyPrinter.levelEmojis[event.level];
    var color =  levelColors[event.level];
    var logString = '[$timestamp] $emoji $className - ${event.message}';
    return colors == true ? [color(logString)] : [logString];
  }
}

class LogColors {
  static final AnsiColor info = AnsiColor.fg(85);
  static final AnsiColor warning = AnsiColor.fg(214);
  static final AnsiColor debug = AnsiColor.none();
  static final AnsiColor error = AnsiColor.fg(196);
  static final AnsiColor wtf = AnsiColor.fg(206);
}