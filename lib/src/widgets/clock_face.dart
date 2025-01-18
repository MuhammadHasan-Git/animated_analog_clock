import 'dart:math';
import 'package:animated_analog_clock/src/widgets/clock_dial.dart';
import 'package:animated_analog_clock/src/dial_type.dart';
import 'package:animated_analog_clock/src/widgets/hand.dart';
import 'package:flutter/material.dart';

class ClockFace extends StatelessWidget {
  ClockFace({
    super.key,
    required this.currentTime,
    required this.clockSize,
    required this.backgroundColor,
    this.backgroundGradient,
    required this.hourHandColor,
    required this.minuteHandColor,
    required this.secondHandColor,
    required this.hourDashColor,
    required this.minuteDashColor,
    required this.centerDotColor,
    required this.dialType,
    required this.showSecondHand,
    this.numberColor,
    required this.extendMinuteHand,
    required this.extendHourHand,
    required this.extendSecondHand,
    this.backgroundImage,
  }) {
    final hasBackgroundColor = backgroundColor != Colors.transparent;
    final hasBackgroundGradient = backgroundGradient != null;
    final hasBackgroundImage = backgroundImage != null;

    final selectedBackgroundCount = [
      hasBackgroundColor,
      hasBackgroundGradient,
      hasBackgroundImage,
    ].where((element) => element).length;

    assert(
      selectedBackgroundCount <= 1,
      'Only one of backgroundColor, backgroundGradient, or backgroundImage should be provided.',
    );
  }

  final double clockSize;
  final DateTime currentTime;
  final DialType dialType;
  final Color backgroundColor;
  final ImageProvider<Object>? backgroundImage;
  final Gradient? backgroundGradient;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color centerDotColor;
  final Color? hourDashColor;
  final Color? minuteDashColor;
  final Color? numberColor;
  final bool extendSecondHand;
  final bool extendMinuteHand;
  final bool extendHourHand;
  final bool showSecondHand;

  static const _secondHandMultiplier = 2 * pi / 60;
  static const _minuteHandMultiplier = 2 * pi / 60;
  static const _hourHandMultiplier = 2 * pi / 12;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: clockSize,
      height: clockSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundGradient == null ? backgroundColor : null,
        gradient:
            backgroundGradient != null && backgroundColor == Colors.transparent
                ? backgroundGradient
                : null,
        image: backgroundImage != null
            ? DecorationImage(
                image: backgroundImage!,
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (dialType != DialType.none)
            CustomPaint(
              size: Size(clockSize, clockSize),
              painter: ClockDashesPainter(
                clockSize: clockSize,
                dialType: dialType,
                hourDashColor: hourDashColor,
                minuteDashColor: minuteDashColor,
                numberColor: numberColor,
              ),
            ),
          minuteHandBuilder(context),
          hourHandBuilder(context),
          if (showSecondHand) secondHandBuilder(),
          Center(
            child: Container(
              width: clockSize / 20,
              height: clockSize / 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: centerDotColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget secondHandBuilder() {
    return ClockHand(
      handColor: secondHandColor,
      length: 0.7,
      width: clockSize / 100,
      clockSize: clockSize,
      extendedTip: extendSecondHand ? 0.1 : 0,
      angle: (currentTime.second + (currentTime.millisecond / 1000)) *
          _secondHandMultiplier,
    );
  }

  Widget minuteHandBuilder(BuildContext context) {
    return ClockHand(
      handColor: minuteHandColor,
      length: 0.65,
      width: clockSize / 55,
      clockSize: clockSize,
      extendedTip: extendMinuteHand ? 0.1 : 0,
      angle: (currentTime.minute + (currentTime.second / 60)) *
          _minuteHandMultiplier,
    );
  }

  Widget hourHandBuilder(BuildContext context) {
    return ClockHand(
      handColor: hourHandColor,
      length: 0.5,
      extendedTip: extendHourHand ? 0.1 : 0,
      width: clockSize / 45,
      clockSize: clockSize,
      angle: (currentTime.hour % 12 + currentTime.minute / 60) *
          _hourHandMultiplier,
    );
  }
}
