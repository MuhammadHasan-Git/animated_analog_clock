import 'package:animated_analog_clock/animated_analog_clock.dart';
import 'package:example/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const DefaultClockExample(),
      debugShowCheckedModeBanner: false,
      darkTheme:
          ThemeData(colorScheme: const ColorScheme.dark(primary: Colors.white)),
      theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Colors.black)),
      themeMode: ThemeMode.system,
    ),
  );
}

// This is the default animated clock example with transparent background and local time
class DefaultClockExample extends StatelessWidget {
  const DefaultClockExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appbar('Simple Animated Clock'),
      body: const Center(
        child: AnimatedAnalogClock(),
      ),
    );
  }
}
