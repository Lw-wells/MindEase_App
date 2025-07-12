// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/animated_dots.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 1000),
        opacity: animate ? 1.0 : 0.0,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 1000),
          scale: animate ? 1.0 : 0.75,
          curve: Curves.easeInOut,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE0F2FE),
                  Color(0xFFF3E8FF),
                  Color(0xFFD1FAE5),
                ], // sky-100, lavender-100, emerald-100
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        LucideIcons.heart, // Custom heart icon
                        size: 48,
                        color: Color(0xFF0EA5E9), // sky-500
                      ),
                    ),
                  ),
                  const Text(
                    'MindEase',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B), // slate-800
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "You're not alone. Let's talk.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF475569), // slate-600
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Dot(color: Color(0xFF38BDF8)), // sky-400
                      SizedBox(width: 8),
                      Dot(color: Color(0xFFE9D5FF), delay: 100), // lavender-400
                      SizedBox(width: 8),
                      Dot(color: Color(0xFF6EE7B7), delay: 200), // emerald-400
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
