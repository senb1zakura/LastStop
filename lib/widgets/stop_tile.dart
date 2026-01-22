import 'package:flutter/material.dart';
import '../models/stop_model.dart';
import '../utils/constants.dart';

class StopTile extends StatelessWidget {
  final StopModel stop;
  final bool selected;
  final bool isCurrent;
  final VoidCallback onTap;

  const StopTile({
    super.key,
    required this.stop,
    required this.selected,
    required this.onTap,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: selected ? 6 : 2,
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: isCurrent ? kAccentColor : kPrimaryColor.withAlpha(31),
            child: isCurrent ? const Icon(Icons.directions_bus, color: Colors.white) : const Icon(Icons.place, color: Colors.white),
          ),
          title: Text(stop.name, style: selected ? const TextStyle(fontWeight: FontWeight.w700) : null),
          subtitle: Text('id: ${stop.id}', style: kSubtitleStyle),
          trailing: selected ? const Icon(Icons.check_circle, color: kAccentColor) : null,
        ),
      ),
    );
  }
}
