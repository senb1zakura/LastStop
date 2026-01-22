import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/stop_model.dart';
import '../services/stop_service.dart';
import '../services/alarm_service.dart';
import '../utils/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final List<StopModel> _stops = StopService.getStops();
  final AlarmService _alarm = AlarmService.instance;

  @override
  Widget build(BuildContext context) {
    final target = _alarm.target;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта остановок'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        actions: [
          if (target != null)
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () => _centerOnStop(target),
              tooltip: 'Показать выбранную остановку',
            ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: target?.position ?? const LatLng(49.8015, 73.1094), // Центр на выбранной или Караганде
          initialZoom: 13.0,
          maxZoom: 18.0,
          minZoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.flutter_application_1',
          ),
          MarkerLayer(
            markers: _stops.map((stop) {
              final isSelected = target == stop;
              return Marker(
                point: stop.position,
                width: isSelected ? 50 : 40,
                height: isSelected ? 50 : 40,
                child: GestureDetector(
                  onTap: () => _onStopTap(stop),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? kAccentColor : kPrimaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: isSelected ? 3 : 2),
                      boxShadow: [
                        BoxShadow(
                          color: (isSelected ? kAccentColor : kPrimaryColor).withAlpha(77),
                          blurRadius: isSelected ? 12 : 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      isSelected ? Icons.location_on : Icons.location_on_outlined,
                      color: Colors.white,
                      size: isSelected ? 24 : 20,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButton: target != null
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.pushReplacementNamed(context, '/alarm'),
              label: const Text('К будильнику'),
              icon: const Icon(Icons.alarm),
              backgroundColor: kAccentColor,
            )
          : null,
    );
  }

  void _onStopTap(StopModel stop) {
    _alarm.setTarget(stop);
    _alarm.setEnabled(true);
    _centerOnStop(stop);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Выбрана остановка: ${stop.name}'),
        backgroundColor: kPrimaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _centerOnStop(StopModel stop) {
    _mapController.move(stop.position, 15.0);
  }
}