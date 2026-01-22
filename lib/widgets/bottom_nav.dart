import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/alarm_screen.dart';
import '../utils/constants.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({super.key, required this.currentIndex});

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;
    Navigator.pushReplacementNamed(context, index == 0 ? '/' : '/alarm');
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Home
            GestureDetector(
              onTap: () => _navigate(context, 0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.home_filled, color: kPrimaryColor),
              ),
            ),
            // Alarm
            GestureDetector(
              onTap: () => _navigate(context, 1),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.alarm, color: kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
