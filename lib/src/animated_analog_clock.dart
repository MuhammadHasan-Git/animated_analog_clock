import 'dart:async';
import 'dart:math';
import 'package:animated_analog_clock/src/analog_clock_painter.dart';
import 'package:flutter/material.dart';

class AnimatedAnalogClock extends StatefulWidget {
  final double size;
  final DateTime? clockTime;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final Color? hourHandColor;
  final Color? minuteHandColor;
  final Color? secondHandColor;
  final Color? hourIndicatorColor;
  final Color? minuteIndicatorColor;
  final Color? centerDotColor;

  /// animated analog clock
  const AnimatedAnalogClock(
      {super.key,
      required this.size,
      this.backgroundColor,
      this.backgroundGradient,
      this.hourHandColor,
      this.minuteHandColor,
      this.secondHandColor,
      this.hourIndicatorColor,
      this.minuteIndicatorColor,
      this.centerDotColor,
      this.clockTime});

  @override
  State<AnimatedAnalogClock> createState() => _AnimatedAnalogClockState();
}

class _AnimatedAnalogClockState extends State<AnimatedAnalogClock>
    with TickerProviderStateMixin, ChangeNotifier {
  Timer? timer;
  late ValueNotifier<DateTime> currentTime =
      ValueNotifier(widget.clockTime ?? DateTime.now());
  late AnimationController hourAnimationController;
  late AnimationController minuteAnimationController;
  late AnimationController secondAnimationController;

  void startClockTime() {
    timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) => currentTime.value = DateTime.now(),
    );
  }

  @override
  void initState() {
    startClockTime();
    hourAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(hours: 12),
      value: (currentTime.value.hour % 12.0 + currentTime.value.minute / 60.0) /
          12.0,
    )..repeat();
    minuteAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 60),
      value: currentTime.value.minute / 60.0,
    )..repeat();
    secondAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
      value: currentTime.value.second / 60.0,
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: ValueListenableBuilder(
          valueListenable: currentTime,
          builder: (context, value, child) => CustomPaint(
            painter: AnalogClockPainter(
              context: context,
              dateTime: currentTime.value,
              hourAnimation: Tween<double>(begin: 0, end: 360)
                  .animate(hourAnimationController),
              minuteAnimation: Tween<double>(begin: 0, end: 360)
                  .animate(minuteAnimationController),
              secondAnimation: Tween<double>(begin: 0, end: 360)
                  .animate(secondAnimationController),
              hourHandColor: widget.hourHandColor,
              minuteHandColor: widget.minuteHandColor,
              secondHandColor: widget.secondHandColor,
              hourIndicatorColor: widget.hourIndicatorColor,
              minuteIndicatorColor: widget.minuteIndicatorColor,
              backgroundColor: widget.backgroundColor,
              backgroundGradient: widget.backgroundGradient,
              centerDotColor: widget.centerDotColor,
            ),
          ),
        ),
      ),
    );
  }
}
