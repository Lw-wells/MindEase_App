import 'package:flutter/material.dart';

class EmergencyCard extends StatelessWidget {
  final VoidCallback onTap;

  const EmergencyCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2), // red-50
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFECACA)), // red-200
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          children: const [
            Icon(Icons.phone, size: 32, color: Color(0xFFEF4444)), // red-500
            SizedBox(height: 8),
            Text(
              "Emergency Support",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFFB91C1C),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Available 24/7 when you need immediate help",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFFDC2626)),
            ),
          ],
        ),
      ),
    );
  }
}
