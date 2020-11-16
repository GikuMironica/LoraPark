import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/rat.dart';
import 'package:lorapark_app/data/models/sensors/rat_data.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';

class RatController extends ChangeNotifier {
  RatRepository _repository;
  final Logger _logger =
      GetIt.I.get<LoggingService>().getLogger((RatController).toString());
  final ScrollController _scrollController = ScrollController();
  RatData _data;

  RatController({RatRepository repository}) {
    _repository = repository;
  }

  Future<void> fetchData() async {
    _data = await _repository.get();
    _logger.d('Fetching data');
    notifyListeners();
  }

  RatData get data => _data;

  List<RatVisitData> get ratVisits => _data.visits;

  String get poison => _data.poison;

  String get decoy => _data.decoy;

  ScrollController get scrollController => _scrollController;
}
