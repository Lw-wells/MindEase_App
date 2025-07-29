import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 🧩 Import reusable components from widgets
import '../widgets/gradient_card.dart';
import '../widgets/glass_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/emergency_card.dart';

class HomeScreen extends StatelessWidget {
  final String userName;
  final bool isAnonymous;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.isAnonymous,
  });

  @override
  Widget build(BuildContext context) {
    final moodEmojis = ['😞', '😐', '🙂', '😄', '😊'];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF0F9FF),
              Color(0xFFF5F3FF),
            ], // sky-50 to lavender-50
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi $userName 👋',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'How are you feeling today?',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/profile'),
                          icon: const Icon(LucideIcons.user),
                        ),
                        IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/settings'),
                          icon: const Icon(LucideIcons.settings),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // CTA Card
                      GradientCard(
                        icon: LucideIcons.messageCircle,
                        title: "Ready to talk?",
                        subtitle:
                            "Start a conversation with Maya, your AI wellness companion",
                        buttonText: "Start a Conversation",
                        onTap: () => Navigator.pushNamed(context, '/chat'),
                      ),
                      const SizedBox(height: 16),

                      // Mood Check-In
                      GlassCard(
                        title: "Quick Mood Check-in",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: moodEmojis
                              .map(
                                (emoji) => IconButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    '/mood-journal',
                                  ),
                                  icon: Text(
                                    emoji,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Quick Actions Grid
                      Row(
                        children: [
                          Expanded(
                            child: QuickActionCard(
                              icon: LucideIcons.users,
                              title1: "Talk to a",
                              title2: "Counselor",
                              color: const Color(0xFF8B5CF6),
                              onTap: () =>
                                  Navigator.pushNamed(context, '/counselor'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: QuickActionCard(
                              icon: LucideIcons.bookOpen,
                              title1: "Mental Health",
                              title2: "Resources",
                              color: const Color(0xFF10B981),
                              onTap: () =>
                                  Navigator.pushNamed(context, '/resources'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Emergency Support
                      EmergencyCard(
                        onTap: () => Navigator.pushNamed(context, '/emergency'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
