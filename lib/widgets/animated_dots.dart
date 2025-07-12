// lib/widgets/animated_dots.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Dot extends StatelessWidget {
  final Color color;
  final int delay;

  const Dot({super.key, required this.color, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        MoveEffect(
          begin: const Offset(0, 0),
          end: const Offset(0, -6),
          duration: const Duration(milliseconds: 600),
          delay: Duration(milliseconds: delay),
          curve: Curves.easeInOut,
          // reverseDuration: const Duration(milliseconds: 600),
        ),
      ],
      onPlay: (controller) => controller.repeat(reverse: true),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
