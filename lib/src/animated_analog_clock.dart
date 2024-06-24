import 'dart:async';
import 'package:animated_analog_clock/src/widgets/clock_face.dart';
import 'package:animated_analog_clock/src/dial_type.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AnimatedAnalogClock extends StatefulWidget {
  /// If this property is null then [AnalogClockState.size] value is [MediaQuery.of(context).size.height * 0.3].
  final double? size;

  /// If null, current location use for the timezone [DateTime.now()]
  ///
  /// Check out the timezone names from [this link](https://help.syncfusion.com/flutter/calendar/timezone).
  final String? location;

  /// change background color of clock face
  ///
  /// If null, [Colors.transparent] is use
  final Color backgroundColor;

  /// To add Gradient color in clock face background
  final Gradient? backgroundGradient;

  /// Property to change hour hand color
  ///
  /// If null, [Theme.of(context).colorScheme.primary] color is used
  final Color? hourHandColor;

  /// Property to change minute hand color
  ///
  /// If null, [Theme.of(context).colorScheme.primary] color is used
  final Color? minuteHandColor;

  /// Property to change second hand color
  ///
  /// If null, [Color(0xFFfa1e1e)] color is used
  final Color secondHandColor;

  /// Property to change dial hour dash color
  ///
  /// If null, [Colors.black] color is used
  final Color? hourDashColor;

  /// If null, [Colors.grey] color is used
  final Color? minuteDashColor;

  /// change the color of the center dot of clock face default color [Color(0xFFfa1e1e)]
  final Color? centerDotColor;

  /// Property to change dial number style
  ///
  /// If null, [DialType.dashes] is used
  final DialType dialType;

  /// Property to show or hide the seconds hand
  ///
  /// If null, [true] is used
  final bool showSecondHand;

  /// Property to change dial number color
  ///
  /// If null, [Colors.white] color is used
  final Color? numberColor;

  /// Property to show or hide the seconds hand
  ///
  /// If null, [false] is used
  final bool? extendSecondHand;

  /// Property to extend second hand
  ///
  /// If null, [false] is used
  final bool? extendMinuteHand;

  /// Property to extend hour hand
  ///
  /// If null, [false] is used
  final bool? extendHourHand;

  /// Property to specify the duration for updating the time
  final Duration? updateInterval;

  /// Animated Analog Clock Widget
  const AnimatedAnalogClock({
    super.key,
    this.size,
    this.backgroundColor = Colors.transparent,
    this.backgroundGradient,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor = const Color(0xFFfa1e1e),
    this.hourDashColor,
    this.minuteDashColor,
    this.centerDotColor,
    this.location,
    this.dialType = DialType.dashes,
    this.showSecondHand = true,
    this.numberColor,
    this.extendMinuteHand,
    this.extendHourHand,
    this.extendSecondHand,
    this.updateInterval,
  });

  @override
  State<AnimatedAnalogClock> createState() => _AnimatedAnalogClockState();
}

class _AnimatedAnalogClockState extends State<AnimatedAnalogClock> {
  Timer? timer;
  late ValueNotifier<DateTime> currentTime;

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

  /// update the clock time in every 10 milliseconds
  void startClockTime() {
    timer = Timer.periodic(
      widget.updateInterval ??
          (widget.showSecondHand
              ? const Duration(milliseconds: 16)
              : const Duration(seconds: 2)),
      (timer) => currentTime.value = locationTime,
    );
  }

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    currentTime = ValueNotifier(locationTime);
    startClockTime();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTime,
      builder: (context, value, child) => ClockFace(
        clockSize: widget.size ?? MediaQuery.of(context).size.height * 0.3,
        currentTime: currentTime.value,
        hourHandColor:
            widget.hourHandColor ?? Theme.of(context).colorScheme.primary,
        minuteHandColor:
            widget.minuteHandColor ?? Theme.of(context).colorScheme.primary,
        secondHandColor: widget.secondHandColor,
        centerDotColor:
            widget.centerDotColor ?? Theme.of(context).colorScheme.primary,
        hourDashColor: widget.hourDashColor,
        minuteDashColor: widget.minuteDashColor,
        backgroundColor: widget.backgroundColor,
        backgroundGradient: widget.backgroundGradient,
        dialType: widget.dialType,
        showSecondHand: widget.showSecondHand,
        numberColor: widget.numberColor,
        extendSecondHand: widget.extendSecondHand ?? true,
        extendMinuteHand: widget.extendMinuteHand ?? false,
        extendHourHand: widget.extendHourHand ?? false,
      ),
    );
  }
}
