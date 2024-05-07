import 'dart:math';
import 'package:flutter/material.dart';

class AnalogClockPainter extends CustomPainter {
  final Animation<double> hourAnimation;
  final Animation<double> minuteAnimation;
  final Animation<double> secondAnimation;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final Color? hourHandColor;
  final Color? minuteHandColor;
  final Color? secondHandColor;
  final Color? hourIndicatorColor;
  final Color? minuteIndicatorColor;
  final Color? centerDotColor;

  final BuildContext context;
  AnalogClockPainter({
    super.repaint,
    required this.context,
    required this.hourAnimation,
    required this.minuteAnimation,
    required this.secondAnimation,
    this.backgroundColor,
    this.backgroundGradient,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor,
    this.hourIndicatorColor,
    this.minuteIndicatorColor,
    this.centerDotColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY) - 20;

    // clock background color
    var fillBrush = Paint();
    backgroundGradient != null && backgroundColor == null
        ? fillBrush.shader = backgroundGradient?.createShader(Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2))
        : fillBrush.color = backgroundColor ?? Colors.transparent;

    canvas.drawCircle(center, radius + 5, fillBrush);

    // clock center circle style
    var centerFillBrush = Paint()
      ..color = centerDotColor ?? Theme.of(context).colorScheme.primary;

    // clock second hand style
    var secHandBrush = Paint()
      ..color = secondHandColor ?? const Color(0xFFfa1e1e)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 120;

    // clock minute hand style
    var minHandBrush = Paint()
      ..color = minuteHandColor ?? Theme.of(context).colorScheme.primary
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 80;

    // clock hour hand style
    var hourHandBrush = Paint()
      ..color = hourHandColor ?? Theme.of(context).colorScheme.primary
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 50;

    // paint hour dial dashes
    var hourIndicator = Paint()
      ..color = hourIndicatorColor ?? Theme.of(context).colorScheme.primary
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    // paint minute dial dashes
    var minuteIndicator = Paint()
      ..color = minuteIndicatorColor ?? Colors.grey
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    // hour hand angle logic
    var hourHandX =
        centerX + radius * 0.4 * cos(hourAnimation.value * pi / 180);
    var hourHandY =
        centerX + radius * 0.4 * sin(hourAnimation.value * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    // minute hand angle logic
    var minHandX =
        centerX + radius * 0.6 * cos(minuteAnimation.value * pi / 180);
    var minHandY =
        centerX + radius * 0.6 * sin(minuteAnimation.value * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    // second hand angle logic
    var secHandX =
        centerX + radius * 0.65 * cos(secondAnimation.value * pi / 180);
    var secHandY =
        centerX + radius * 0.65 * sin(secondAnimation.value * pi / 180);
    canvas.drawLine(
        Offset(centerX, centerY), Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, radius * 0.06, centerFillBrush);

    const double angle = 2 * pi;
    const double anglePerHour = angle / 12;
    const double anglePerMinute = angle / 60;

    //second dial dashes
    for (int i = 0; i < 60; i++) {
      final double x1 = centerX + radius * cos(i * anglePerMinute);
      final double y1 = centerY + radius * sin(i * anglePerMinute);
      final double x2 = centerX + (radius - 10 / 2) * cos(i * anglePerMinute);
      final double y2 = centerY + (radius - 10 / 2) * sin(i * anglePerMinute);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), minuteIndicator);
    }

    // hour dial dashes
    for (int i = 0; i < 12; i++) {
      final double x1 = centerX + radius * cos(i * anglePerHour);
      final double y1 = centerY + radius * sin(i * anglePerHour);
      final double x2 = centerX + (radius - 10) * cos(i * anglePerHour);
      final double y2 = centerY + (radius - 10) * sin(i * anglePerHour);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourIndicator);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
