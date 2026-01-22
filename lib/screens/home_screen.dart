import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/app_button.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

                // Placeholder mini map card
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kCardColor,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Color.fromRGBO(0,0,0,0.04), blurRadius: 12, offset: const Offset(0,6))],
                  ),
                  child: const Center(
                    child: Text('MINI MAP', style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1)),
                  ),
                ),

                const SizedBox(height: 14),

                // Main content card
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kCardColor,
                      borderRadius: kRadius,
                      boxShadow: [BoxShadow(color: Color.fromRGBO(0,0,0,0.03), blurRadius: 18, offset: const Offset(0,8))],
                    ),
                    padding: const EdgeInsets.all(kPadding),
                    child: const Center(
                      child: Text('MAPS', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                    ),
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
