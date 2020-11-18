import 'package:lorapark_app/utils/utils.dart' show LoggingPrinter;
import 'package:logger/logger.dart';

class LoggingService {
  static LoggingService _loggingService;
  List<LPLogger> _loggerList;
  bool enableColors;

  factory LoggingService({enableColors = false}) {
    return _loggingService ??= LoggingService._(colors: enableColors);
  }

  LoggingService._({bool colors}){
    _loggerList = [LPLogger('LoRaPark', colors)];
  }

  LPLogger getLogger(String className) {
    for(var logger in _loggerList){
      if(logger.className == className){
        return logger;
      }
    }
    var lpLogger = LPLogger(className, enableColors);
    _loggerList.add(lpLogger);
    return lpLogger;
  }
}

class LPLogger extends Logger {
  final String className;
  final bool colors;

  LPLogger(this.className, this.colors)
      : super(printer: LoggingPrinter(className: className, colors: colors));
}