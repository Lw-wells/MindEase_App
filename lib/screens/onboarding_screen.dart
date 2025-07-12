import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'icon': LucideIcons.heart,
      'title': 'Welcome to MindEase',
      'description':
          'Get emotional support through AI-powered conversations and connect with real counselors when you need them most.',
      'illustration': '🤗',
      'color': Color(0xFF0EA5E9), // sky-500
    },
    {
      'icon': LucideIcons.shield,
      'title': 'Your Privacy Matters',
      'description':
          'Your conversations are confidential and secure. We prioritize your anonymity and data protection above all else.',
      'illustration': '🔒',
      'color': Color(0xFF10B981), // emerald-500
    },
    {
      'icon': LucideIcons.userPlus,
      'title': 'Get Started',
      'description':
          "Choose how you'd like to begin your mental wellness journey with us.",
      'illustration': '🌱',
      'color': Color(0xFF8B5CF6), // lavender-500
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      setState(() => currentPage++);
    }
  }

  void prevPage() {
    if (currentPage > 0) {
      setState(() => currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = pages[currentPage];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0F9FF), Color(0xFFF5F3FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Card(
                  elevation: 6,
                  color: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          page['illustration'],
                          style: const TextStyle(fontSize: 48),
                        ),
                        const SizedBox(height: 24),
                        Icon(page['icon'], size: 64, color: page['color']),
                        const SizedBox(height: 24),
                        Text(
                          page['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['description'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF475569),
                          ),
                        ),
                        if (currentPage == pages.length - 1) ...[
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: widget.onComplete,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0EA5E9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: const Text("Use Anonymously"),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: widget.onComplete,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF0EA5E9),
                              side: const BorderSide(color: Color(0xFFBAE6FD)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: const Text("Sign In with Email/Google"),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: prevPage,
                  icon: const Icon(LucideIcons.chevronLeft, size: 20),
                  color: currentPage > 0
                      ? const Color(0xFF475569)
                      : Colors.grey[300],
                ),
                Row(
                  children: List.generate(
                    pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage == index
                            ? const Color(0xFF0EA5E9)
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: nextPage,
                  icon: const Icon(LucideIcons.chevronRight, size: 20),
                  color: currentPage < pages.length - 1
                      ? const Color(0xFF475569)
                      : Colors.grey[300],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
