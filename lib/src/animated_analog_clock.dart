import 'dart:async';
import 'dart:math';
import 'package:animated_analog_clock/src/analog_clock_painter.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AnimatedAnalogClock extends StatefulWidget {
  /// If this property is null then [AnalogClockState.size] value is [MediaQuery.of(context).size.height * 0.3].
  final double? size;

  /// If null, current location use for the timezone [DateTime.now()]
  final String? location;

  /// If null, [Colors.transparent] is use
  final Color? backgroundColor;

  /// To add Gradient color in clock face background
  final Gradient? backgroundGradient;

  /// If null, [Theme.of(context).colorScheme.primary] color is used
  final Color? hourHandColor;

  /// If null, [Theme.of(context).colorScheme.primary] color is used
  final Color? minuteHandColor;

  /// If null, [Color(0xFFfa1e1e)] color is used
  final Color? secondHandColor;

  /// If null, [Theme.of(context).colorScheme.primary] color is used
  final Color? hourIndicatorColor;

  /// If null, [Colors.grey] color is used
  final Color? minuteIndicatorColor;

  /// change the color of the center dot of clock face default color [Color(0xFFfa1e1e)]
  final Color? centerDotColor;

  /// Animated Analog Clock Widget
  const AnimatedAnalogClock({
    super.key,
    this.size,
    this.backgroundColor,
    this.backgroundGradient,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor,
    this.hourIndicatorColor,
    this.minuteIndicatorColor,
    this.centerDotColor,
    this.location,
  });

  @override
  State<AnimatedAnalogClock> createState() => _AnimatedAnalogClockState();
}

class _AnimatedAnalogClockState extends State<AnimatedAnalogClock>
    with TickerProviderStateMixin {
  Timer? timer;
  late ValueNotifier<DateTime> currentTime;
  late AnimationController hourAnimationController;
  late AnimationController minuteAnimationController;
  late AnimationController secondAnimationController;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    currentTime = ValueNotifier(locationTime);
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
  }

  /// getter for getting specified location timezone
  DateTime get locationTime {
    if (widget.location != null) {
      var detroit = tz.getLocation(widget.location!);
      var now = tz.TZDateTime.now(detroit);
      return now;
    } else {
      return DateTime.now();
    }
  }

  /// update the clcok time in every 10 milliseconds
  void startClockTime() {
    timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) => currentTime.value = locationTime,
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    currentTime.dispose();
    hourAnimationController.dispose();
    minuteAnimationController.dispose();
    secondAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size ?? MediaQuery.of(context).size.height * 0.3,
      height: widget.size ?? MediaQuery.of(context).size.height * 0.3,
      child: Transform.rotate(
        angle: -pi / 2,
        child: ValueListenableBuilder(
          valueListenable: currentTime,
          builder: (context, value, child) => CustomPaint(
            painter: AnalogClockPainter(
              context: context,
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
