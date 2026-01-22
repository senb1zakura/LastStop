import '../models/stop_model.dart';

class StopService {
  // Мок-данные — легко заменить на реальный источник
  static List<StopModel> getStops() {
    return [
      StopModel(id: 's1', name: 'Central Park'),
      StopModel(id: 's2', name: 'Main Street'),
      StopModel(id: 's3', name: 'University'),
      StopModel(id: 's4', name: 'Airport'),
      StopModel(id: 's5', name: 'Buhar Jirau (Terminal)'),
    ];
  }

  static StopModel? getById(String id) {
    final list = getStops();
    try {
      return list.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  static StopModel? getPreLastStop(List<StopModel> stops, StopModel lastStop) {
    final index = stops.indexOf(lastStop);
    if (index <= 0) return null;
    return stops[index - 1];
  }
}
