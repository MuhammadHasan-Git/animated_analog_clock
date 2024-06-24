import 'package:flutter/material.dart';

class ClockHand extends StatelessWidget {
  final Color handColor;
  final double angle;
  final double length;
  final double width;
  final double clockSize;
  final double extendedTip;

  const ClockHand({
    super.key,
    required this.handColor,
    required this.angle,
    required this.length,
    required this.width,
    required this.clockSize,
    this.extendedTip = 0,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the hand size based on the clock size
    final double size = clockSize * length;
    return Center(
      child: Transform.rotate(
        angle: angle,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              height: size * (0.5 + extendedTip),
              decoration: BoxDecoration(
                color: handColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            ),
            // This SizedBox is for the center dot of the clock, ensure the center alignment
            SizedBox(
              width: 2,
              height: size * (0.5 - extendedTip),
            ),
          ],
        ),
      ),
    );
  }
}
