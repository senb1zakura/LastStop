import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/alarm_screen.dart';
import 'utils/constants.dart';
import 'services/alarm_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализация сервиса (singleton)
  AlarmService.instance.init();
  runApp(const LastStopApp());
}

class LastStopApp extends StatelessWidget {
  const LastStopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastStop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      routes: {
        '/': (_) => const HomeScreen(),
        '/alarm': (_) => const AlarmScreen(),
      },
      initialRoute: '/',
    );
  }
}
