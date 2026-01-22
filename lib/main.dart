import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/alarm_screen.dart';
import 'screens/map_screen.dart';
import 'utils/constants.dart';
import 'services/alarm_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize services
  AlarmService.instance.init();
  runApp(const LastStopApp());
}

class LastStopApp extends StatelessWidget {
  const LastStopApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = kPrimaryColor;
    return MaterialApp(
      title: 'LastStop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(borderRadius: kRadius),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
        ),
      ),
      routes: {
        '/': (_) => const HomeScreen(),
        '/alarm': (_) => const AlarmScreen(),
        '/map': (_) => const MapScreen(),
      },
      initialRoute: '/',
    );
  }
}
