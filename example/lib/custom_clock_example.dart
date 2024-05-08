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

// This is the custom animated clock example with custom background and time
class CustomClockExample extends StatelessWidget {
  const CustomClockExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appbar('Customized Animated Clock'),
      body: const Center(
        child: AnimatedAnalogClock(
          location: 'Australia/Darwin',
          backgroundColor: Color(0xff1E1E26),
          hourHandColor: Colors.lightBlueAccent,
          minuteHandColor: Colors.lightBlueAccent,
          secondHandColor: Colors.amber,
          centerDotColor: Colors.amber,
          hourIndicatorColor: Colors.lightBlue,
          minuteIndicatorColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
