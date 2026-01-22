import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/app_button.dart';
import '../services/alarm_service.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AlarmService _alarm = AlarmService.instance;

  @override
  void initState() {
    super.initState();
    _alarm.addListener(_onServiceUpdated);
  }

  void _onServiceUpdated() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _alarm.removeListener(_onServiceUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final target = _alarm.target;
    final isEnabled = _alarm.enabled;
    final currentStop = _alarm.stops.isNotEmpty ? _alarm.stops[_alarm.currentIndex] : null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kBgGradientStart, kBgGradientEnd],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              children: [
                const SizedBox(height: 8),

                // Top logo + title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryColor.withAlpha(46),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: const Center(
                        child: Text('LS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('LastStop', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                        SizedBox(height: 2),
                        Text('Karaganda — bus stops', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Status card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kCardColor,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Color.fromRGBO(0,0,0,0.04), blurRadius: 12, offset: const Offset(0,6))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isEnabled ? Icons.alarm_on : Icons.alarm_off,
                            color: isEnabled ? kAccentColor : Colors.grey,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isEnabled ? 'Будильник активен' : 'Будильник выключен',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isEnabled ? kAccentColor : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (target != null) ...[
                        Text('Целевая остановка:', style: TextStyle(fontSize: 14, color: Colors.black54)),
                        const SizedBox(height: 4),
                        Text(target.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ] else ...[
                        Text('Остановка не выбрана', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                      const SizedBox(height: 8),
                      if (currentStop != null) ...[
                        Text('Текущая остановка:', style: TextStyle(fontSize: 14, color: Colors.black54)),
                        const SizedBox(height: 4),
                        Text(currentStop.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Buttons row
                Row(
                  children: [
                    Expanded(
                      child: AppButton.primary(
                        onPressed: () => Navigator.pushNamed(context, '/map'),
                        child: const Text('VIEW MAP'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton.secondary(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/alarm'),
                        child: const Text('CHANGE STOP'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
