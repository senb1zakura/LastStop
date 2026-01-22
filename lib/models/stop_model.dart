import 'package:latlong2/latlong.dart';

class StopModel {
  final String id;
  final String name;
  final LatLng position;

  StopModel({required this.id, required this.name, required this.position});

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
