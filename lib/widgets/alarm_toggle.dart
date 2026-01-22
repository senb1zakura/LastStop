import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AlarmToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const AlarmToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('MODE', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: kCardColor,
            borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Color.fromRGBO(0,0,0,0.03), blurRadius: 6)],
          ),
          child: Row(
            children: [
              Text('Time', style: TextStyle(color: value ? Colors.black54 : kPrimaryColor)),
                  Switch(value: value, onChanged: onChanged),
              Text('Stop', style: TextStyle(color: value ? kPrimaryColor : Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }
}
