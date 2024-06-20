import 'dart:math';
import 'package:animated_analog_clock/src/dial_type.dart';
import 'package:flutter/material.dart';

class ClockDashesPainter extends CustomPainter {
  final double clockSize;
  final Color? hourDashColor;
  final DialType dialType;
  final Color? minuteDashColor;
  final Color? numberColor;

  ClockDashesPainter({
    required this.clockSize,
    this.hourDashColor,
    this.minuteDashColor,
    required this.dialType,
    this.numberColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double padding = clockSize / 20;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = clockSize / 2;
    final hourDashLength = clockSize / 15;
    final minuteDashLength = clockSize / 30;

    final hourPaint = Paint()
      ..color = hourDashColor ?? Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5;

    final minutePaint = Paint()
      ..color = minuteDashColor ?? Colors.grey
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    if (dialType == DialType.numberAndDashes) {
      // Draw hour dashes that not contain
      for (int i = 0; i < 12; i++) {
        if (![0, 3, 6, 9].contains(i)) {
          final angle = 2 * pi * i / 12;
          final startX = center.dx + (radius - padding) * cos(angle);
          final startY = center.dy + (radius - padding) * sin(angle);
          final endX = center.dx + (radius - hourDashLength * 1.5) * cos(angle);
          final endY = center.dy + (radius - hourDashLength * 1.5) * sin(angle);
          canvas.drawLine(
              Offset(startX, startY), Offset(endX, endY), hourPaint);
        }
      }
    }

    if (dialType == DialType.dashes) {
      // Draw hour dashes
      for (int i = 0; i < 12; i++) {
        final angle = 2 * pi * i / 12;
        final startX = center.dx + (radius - padding) * cos(angle);
        final startY = center.dy + (radius - padding) * sin(angle);
        final endX =
            center.dx + (radius - padding - hourDashLength) * cos(angle);
        final endY =
            center.dy + (radius - padding - hourDashLength) * sin(angle);
        canvas.drawLine(Offset(startX, startY), Offset(endX, endY), hourPaint);
      }
    }
    if (dialType == DialType.dashes) {
      // Draw minute dashes
      for (int i = 0; i < 60; i++) {
        if (i % 5 != 0) {
          final angle = 2 * pi * i / 60;
          final startX = center.dx + (radius - padding) * cos(angle);
          final startY = center.dy + (radius - padding) * sin(angle);
          final endX =
              center.dx + (radius - padding - minuteDashLength) * cos(angle);
          final endY =
              center.dy + (radius - padding - minuteDashLength) * sin(angle);
          canvas.drawLine(
              Offset(startX, startY), Offset(endX, endY), minutePaint);
        }
      }
    }

    if (dialType == DialType.numberAndDashes) {
      // Draw numbers 12, 3, 6, 9
      for (int i in [0, 3, 6, 9]) {
        final angle =
            2 * pi * (i - 3) / 12; // Adjust the angle for correct positioning
        final numberX = center.dx + (radius - hourDashLength) * cos(angle);
        final numberY = center.dy + (radius - hourDashLength) * sin(angle);
        textPainter.text = TextSpan(
          text: (i == 0 ? 12 : i).toString(),
          style: TextStyle(
            fontSize: clockSize / 16,
            color: numberColor ?? Colors.white,
            fontWeight: FontWeight.w500,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            numberX - textPainter.width / 2,
            numberY - textPainter.height / 2,
          ),
        );
      }
    }

    // Draw numbers
    if (dialType == DialType.numbers) {
      for (int i = 1; i <= 12; i++) {
        final angle =
            2 * pi * (i - 3) / 12; // Adjust the angle for correct positioning
        final numberX =
            center.dx + (radius - hourDashLength * 1.2) * cos(angle);
        final numberY =
            center.dy + (radius - hourDashLength * 1.2) * sin(angle);
        textPainter.text = TextSpan(
          text: i.toString(),
          style: TextStyle(
            fontSize: clockSize / 16,
            color: numberColor ?? Colors.white,
            fontWeight: FontWeight.w500,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            numberX - textPainter.width / 2,
            numberY - textPainter.height / 2,
          ),
        );
      }
    }

    if (dialType == DialType.romanNumerals) {
      const List<String> romanNumerals = [
        'XII',
        'I',
        'II',
        'III',
        'IV',
        'V',
        'VI',
        'VII',
        'VIII',
        'IX',
        'X',
        'XI'
      ];

      for (int i = 0; i < 12; i++) {
        final angle = 2 * pi * (i - 3) / 12;
        final offsetX = (clockSize / 2) + (clockSize / 2.4) * cos(angle);
        final offsetY = (clockSize / 2) + (clockSize / 2.4) * sin(angle);

        textPainter.text = TextSpan(
          text: romanNumerals[i],
          style: TextStyle(
            fontSize: clockSize / 16,
            color: numberColor ?? Colors.white,
            fontWeight: FontWeight.w500,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            offsetX - textPainter.width / 2,
            offsetY - textPainter.height / 2,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
