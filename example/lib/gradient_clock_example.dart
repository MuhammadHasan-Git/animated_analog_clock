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

// This is the gradient animated clock example with custom gradient background and time
class CustomClockExample extends StatelessWidget {
  const CustomClockExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appbar('Gradient Animated Clock'),
      body: const Center(
        child: AnimatedAnalogClock(
          location: 'Australia/Sydney',
          backgroundGradient: RadialGradient(
            colors: [
              Color(0xff152238),
              Color(0xff3c649f),
            ],
          ),
          hourHandColor: Colors.white,
          minuteHandColor: Colors.white,
          secondHandColor: Colors.lightBlueAccent,
          centerDotColor: Colors.lightBlueAccent,
          hourIndicatorColor: Colors.lightBlueAccent,
        ),
      ),
    );
  }
}
