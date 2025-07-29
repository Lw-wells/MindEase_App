// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileScreen extends StatefulWidget {
  final String userName;
  final bool isAnonymous;
  final Function(String name, bool isAnonymous) onSave;
  final VoidCallback onBack;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.isAnonymous,
    required this.onSave,
    required this.onBack,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late bool _anonymousMode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName);
    _anonymousMode = widget.isAnonymous;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSave() {
    widget.onSave(_nameController.text, _anonymousMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Color(0xFF1E293B)),
        ),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.black),
          onPressed: widget.onBack,
        ),
        actions: [
          TextButton(
            onPressed: _handleSave,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xFF0EA5E9),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar Section
            Card(
              color: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xFFBAE6FD),
                      child: const Icon(
                        LucideIcons.user,
                        size: 40,
                        color: Color(0xFF0EA5E9),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF0EA5E9),
                        side: const BorderSide(color: Color(0xFF0EA5E9)),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text("Change Avatar"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Personal Info
            _sectionCard(
              title: 'Personal Information',
              children: [
                const Text(
                  "Display Name",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xFFBAE6FD)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Use Anonymously",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Hide your identity for privacy",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Switch(
                      value: _anonymousMode,
                      onChanged: (val) => setState(() => _anonymousMode = val),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Privacy
            _sectionCard(
              title: 'Privacy & Security',
              icon: LucideIcons.shield,
              children: [
                _row("Data Encryption", "Enabled", highlight: true),
                _row(
                  "Anonymous Mode",
                  _anonymousMode ? "On" : "Off",
                  highlight: _anonymousMode,
                  danger: !_anonymousMode,
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Color(0xFF0EA5E9)),
                  ),
                  child: const Text(
                    "View Privacy Policy",
                    style: TextStyle(color: Color(0xFF0EA5E9)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Preferences
            _sectionCard(
              title: 'Preferences',
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(LucideIcons.globe),
                  title: const Text("Language: English"),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Danger Zone
            _sectionCard(
              title: 'Account Actions',
              color: const Color(0xFFFFEBEE),
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.trash2, color: Colors.red),
                  label: const Text(
                    "Delete My Data",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.logOut, color: Colors.red),
                  label: const Text(
                    "Log Out",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    IconData? icon,
    required List<Widget> children,
    Color color = Colors.white,
  }) {
    return Card(
      color: color.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Row(
                children: [
                  Icon(icon, size: 18, color: Colors.grey[800]),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            else
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _row(
    String left,
    String right, {
    bool highlight = false,
    bool danger = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: const TextStyle(fontSize: 14)),
        Text(
          right,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: danger
                ? Colors.red
                : highlight
                ? const Color(0xFF10B981)
                : Colors.grey,
          ),
        ),
      ],
    );
  }
}
