// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mindease/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Make sure this file exists

import 'theme/theme_provider.dart';
import 'package:mindease/screens/splash_screen.dart';
import 'package:mindease/screens/onboarding_screen.dart';
import 'package:mindease/screens/home_screen.dart';
import 'package:mindease/screens/counselor_screen.dart';
import 'package:mindease/screens/chat_screen.dart';
import 'package:mindease/screens/profile_screen.dart';
import 'package:mindease/screens/settings_screen.dart';
import 'package:mindease/screens/resources_screen.dart';
import 'package:mindease/screens/emergency_screen.dart';
import 'package:mindease/screens/mood_journal_screen.dart';
import 'package:mindease/screens/login_screen.dart';
import 'package:mindease/screens/signup_screen.dart';
import 'package:mindease/screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before Firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MindEaseApp(),
    ),
  );
}

class MindEaseApp extends StatelessWidget {
  const MindEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'MindEase',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeProvider.currentTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashWrapper(),
        '/onboarding': (context) => OnboardingScreen(
          onComplete: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/auth': (context) => const AuthScreen(),

        '/home': (context) =>
            const HomeScreen(userName: "Guest", isAnonymous: true),
        '/counselor': (context) => CounselorScreen(
          onNavigate: (route) {
            Navigator.pushNamed(context, '/$route');
          },
        ),
        '/chat': (context) => const ChatScreen(),
        '/profile': (context) => ProfileScreen(
          userName: "Guest",
          isAnonymous: true,
          onSave: (name, isAnon) {
            Navigator.pushReplacementNamed(context, '/home');
          },
          onBack: () => Navigator.pop(context),
        ),
        '/settings': (context) => SettingsScreen(
          onNavigate: (route) {
            Navigator.pushNamed(context, '/$route');
          },
        ),
        '/resources': (context) => ResourcesScreen(
          onNavigate: (route) {
            Navigator.pushNamed(context, '/$route');
          },
        ),
        '/emergency': (context) => EmergencyScreen(
          onNavigate: (route) {
            Navigator.pushNamed(context, '/$route');
          },
        ),
        '/mood-journal': (context) => MoodJournalScreen(
          onNavigate: (route) {
            Navigator.pushNamed(context, '/$route');
          },
        ),
      },
    );
  }
}

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
