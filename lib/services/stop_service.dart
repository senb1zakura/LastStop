import '../models/stop_model.dart';
import 'package:latlong2/latlong.dart';

class StopService {
  // Мок-данные — легко заменить на реальный источник
  static List<StopModel> getStops() {
    return [
      StopModel(
        id: 's1',
        name: 'Central Park',
        position: const LatLng(49.8015, 73.1094),
      ),
      StopModel(
        id: 's2',
        name: 'Main Street',
        position: const LatLng(49.8020, 73.1100),
      ),
      StopModel(
        id: 's3',
        name: 'University',
        position: const LatLng(49.8060, 73.0860),
      ),
      StopModel(
        id: 's4',
        name: 'Airport',
        position: const LatLng(49.6708, 73.3344),
      ),
      StopModel(
        id: 's5',
        name: 'Buhar Jirau (Terminal)',
        position: const LatLng(49.8010, 73.1090),
      ),
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
