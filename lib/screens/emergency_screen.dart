// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  final void Function(String) onNavigate;

  const EmergencyScreen({super.key, required this.onNavigate});

  void _makePhoneCall(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _sendCrisisText() async {
    final uri = Uri.parse('sms:741741?body=HOME');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final emergencyContacts = [
      {
        "name": "National Suicide Prevention Lifeline",
        "number": "988",
        "description": "24/7 crisis support",
        "country": "US",
      },
      {
        "name": "Crisis Text Line",
        "number": "Text HOME to 741741",
        "description": "24/7 text-based crisis support",
        "country": "US",
      },
      {
        "name": "SAMHSA National Helpline",
        "number": "1-800-662-4357",
        "description": "Mental health and substance abuse",
        "country": "US",
      },
      {
        "name": "International Association for Suicide Prevention",
        "number": "Visit iasp.info",
        "description": "Global crisis resources",
        "country": "International",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () => onNavigate("home"),
                    icon: const Icon(LucideIcons.arrowLeft),
                  ),
                  const Text(
                    "Emergency Support",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 🚨 Crisis Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      LucideIcons.alertTriangle,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "In Crisis? Get Help Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "If you're having thoughts of self-harm or suicide, please reach out immediately. You're not alone.",
                      style: TextStyle(color: Color(0xFFFFE4E6)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => _makePhoneCall("988"),
                      icon: const Icon(
                        LucideIcons.phone,
                        color: Color(0xFFDC2626),
                      ),
                      label: const Text("Call 988 Now"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFFDC2626),
                        backgroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      onPressed: _sendCrisisText,
                      icon: const Icon(
                        LucideIcons.messageCircle,
                        color: Colors.white,
                      ),
                      label: const Text("Text Crisis Line"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 📞 Emergency Contacts
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Crisis Resources",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...emergencyContacts.map((contact) {
                return Card(
                  color: Colors.white.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                      contact["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(contact["description"]!),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                contact["country"]!,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              contact["number"]!,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        LucideIcons.phone,
                        color: Color(0xFFEF4444),
                      ),
                      onPressed: () {
                        final number = contact["number"]!;
                        if (RegExp(r"^\d").hasMatch(number)) {
                          _makePhoneCall(number);
                        }
                      },
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // 🛡️ Safety Plan
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Create a Safety Plan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "A safety plan can help you stay safe during difficult times. It includes coping strategies and support contacts.",
                        style: TextStyle(color: Color(0xFF475569)),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => onNavigate("safety_plan"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0EA5E9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: const Text("Create My Safety Plan"),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 💬 Talk to Maya
              Card(
                color: const Color(0xFFE0F2FE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        "Need Someone to Talk To?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Maya is here to listen and provide support anytime you need it.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF475569)),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () => onNavigate("chat"),
                        icon: const Icon(LucideIcons.messageCircle),
                        label: const Text("Talk to Maya"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0369A1),
                          side: const BorderSide(color: Color(0xFFBAE6FD)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
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
