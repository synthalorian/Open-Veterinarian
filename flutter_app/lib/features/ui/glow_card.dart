import 'package:flutter/material.dart';

class GlowCard extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final double blurRadius;

  const GlowCard({
    super.key,
    required this.child,
    this.glowColor = Colors.cyanAccent,
    this.blurRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.1),
            blurRadius: blurRadius,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.white.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: glowColor.withOpacity(0.2), width: 1),
        ),
        child: child,
      ),
    );
  }
}
