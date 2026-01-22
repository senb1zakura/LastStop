import 'package:flutter/material.dart';

class AlarmToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const AlarmToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('TIME / STOP', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
