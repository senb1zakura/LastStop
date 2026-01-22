import 'package:flutter/material.dart';
import '../models/stop_model.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        title: Text(stop.name, style: TextStyle(color: selected ? Colors.white : Colors.black)),
        trailing: selected ? const Icon(Icons.check, color: Colors.white) : (isCurrent ? const Icon(Icons.directions_bus) : null),
        onTap: onTap,
      ),
    );
  }
}
