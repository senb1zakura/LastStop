import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

import '../models/stop_model.dart';
import 'stop_service.dart';

/// AlarmService
/// ----------------------------
/// • Singleton
/// • Управляет остановками
/// • Симулирует движение
/// • Срабатывает ОДИН раз на предпоследней
class AlarmService extends ChangeNotifier {
  AlarmService._internal();
  static final AlarmService instance = AlarmService._internal();

  // ===== AUDIO =====
  final AudioPlayer _player = AudioPlayer();

  // ===== DATA =====
  late final List<StopModel> _stops;
  List<StopModel> get stops => _stops;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  StopModel? _target;
  StopModel? get target => _target;

  bool _enabled = false;
  bool get enabled => _enabled;

  bool _alarmTriggered = false; // 🔥 КЛЮЧЕВО

  Timer? _timer;

  // ===== INIT =====
  void init() {
    _stops = StopService.getStops();
    _currentIndex = 0;
    _alarmTriggered = false;
  }

  // ===== LIFECYCLE =====
  @override
  void dispose() {
    _timer?.cancel();
    _player.dispose();
    super.dispose();
  }

  // ===== TARGET =====
  void setTarget(StopModel stop) {
    _target = stop;
    _alarmTriggered = false; // сброс при новом выборе
    notifyListeners();
  }

  StopModel? getPenultimateStop() {
    if (_target == null) return null;
    return StopService.getPreLastStop(_stops, _target!);
  }

  // ===== ENABLE =====
  void setEnabled(bool value) {
    _enabled = value;

    if (_enabled) {
      startSimulation();
    } else {
      stopSimulation();
    }

    notifyListeners();
  }

  // ===== SIMULATION =====
  void startSimulation({int stepSeconds = 3}) {
    stopSimulation();

    _timer = Timer.periodic(Duration(seconds: stepSeconds), (_) {
      _moveNext();
    });
  }

  void stopSimulation() {
    _timer?.cancel();
    _timer = null;
  }

  void resetPosition() {
    _currentIndex = 0;
    _alarmTriggered = false;
    notifyListeners();
  }

  void _moveNext() {
    _currentIndex++;

    if (_currentIndex >= _stops.length) {
      _currentIndex = 0;
    }

    _checkAlarm();
    notifyListeners();
  }

  // ===== ALARM LOGIC =====
  Future<void> _checkAlarm() async {
    if (!_enabled) return;
    if (_alarmTriggered) return;
    if (_target == null) return;

    final penultimate = getPenultimateStop();
    if (penultimate == null) return;

    final penIndex = _stops.indexOf(penultimate);

    if (penIndex == _currentIndex) {
      _alarmTriggered = true;
      await _playAlarm();
    }
  }

  Future<void> _playAlarm() async {
    try {
      await _player.stop();
      await _player.play(
        AssetSource('alarm.mp3'),
        volume: 1.0,
      );
    } catch (e) {
      if (kDebugMode) {
        print('❌ Alarm error: $e');
      }
    }
  }
}
