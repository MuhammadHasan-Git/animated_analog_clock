import 'package:animated_analog_clock/animated_analog_clock.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_appbar.dart';

void main() {
  runApp(
    MaterialApp(
      home: const ImageClockExample(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(colorScheme: const ColorScheme.dark()),
      theme: ThemeData(colorScheme: const ColorScheme.light()),
      themeMode: ThemeMode.system,
    ),
  );
}

// This is the custom animated clock example with custom background and time
class ImageClockExample extends StatelessWidget {
  const ImageClockExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar('Animated Clock With Image'),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedAnalogClock(
              size: 250,
              backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2023/12/01/22/27/spiderman-8424632_1280.jpg',
              ),
              hourHandColor: Colors.white,
              minuteHandColor: Colors.white,
              secondHandColor: Colors.deepPurpleAccent,
              centerDotColor: Colors.deepPurpleAccent,
              dialType: DialType.numbers,
              // extendHourHand: true,
              // extendMinuteHand: true,
            ),
          ],
        ),
      ),
    );
  }
}
