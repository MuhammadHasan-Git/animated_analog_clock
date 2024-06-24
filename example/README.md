## Example

Here's an example of how to use the `AnimatedAnalogClock` widget:

```dart
import 'package:animated_analog_clock/animated_analog_clock.dart';
import 'package:example/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const CustomClockExample(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(colorScheme: const ColorScheme.dark()),
      theme: ThemeData(colorScheme: const ColorScheme.light()),
      themeMode: ThemeMode.system,
    ),
  );
}

class CustomClockExample extends StatelessWidget {
  const CustomClockExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar('Customized Animated Clock'),
      body: const Center(
        child: AnimatedAnalogClock(
          location: 'Australia/Darwin',
          size: 200,
          backgroundColor: Color(0xff1E1E26),
          hourHandColor: Colors.lightBlueAccent,
          minuteHandColor: Colors.lightBlueAccent,
          secondHandColor: Colors.amber,
          centerDotColor: Colors.amber,
          hourDashColor: Colors.lightBlue,
          minuteDashColor: Colors.blueAccent,
          dialType: DialType.numbers,
          numberColor: Colors.blueAccent,
          extendHourHand: true,
          extendMinuteHand: true,
        ),
      ),
    );
  }
}


