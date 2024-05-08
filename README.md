# Flutter Animated Analog Clock

[![pub package](https://img.shields.io/badge/pub-v0.0.1-orange)](https://pub.dev/packages/animated_analog_clock)

A customizable and animated analog clock widget.
This package provides a fully customizable analog clock widget that supports
animation for smooth transitions of clock hands. Users can customize various
aspects of the clock including size, colors, background, and more.

![Flutter Analog Clock Screenshot](https://github.com/MuhammadHasan-Git/animated_analog_clock/blob/main/screenshots/animated_analog_clock_dark.gif)
&nbsp;
![Flutter Analog Clock Screenshot](https://github.com/MuhammadHasan-Git/animated_analog_clock/blob/main/screenshots/animated_analog_clock_light.gif)

## Installation

In your `pubspec.yaml` file of your Flutter Project, add the following dependency:

```yaml
dependencies:
  analog_clock: ^0.0.1
```

## Import

```dart
import 'package:animated_analog_clock/animated_analog_clock.dart';
```

## Features

- **Customizable Design**: Users can customize various aspects of the analog clock, including size, colors, background, and more, to match their app's design aesthetics.

- **Smooth Animations**: The analog clock widget supports smooth animations for clock hands, providing a visually pleasing experience for users.

- **Timezone Support**: The clock widget supports displaying time in different timezones, allowing users to customize the clock based on their location or preferences.

- **Timezone Support with Location Specification**: Users can specify a location name, and the clock will display the time according to the timezone associated with that location. To find valid location names for timezones, check out the [this](https://help.syncfusion.com/flutter/calendar/timezone) documentation.

- **Lightweight and Efficient**: The package is designed to be lightweight and efficient, ensuring smooth performance even on devices with limited resources.

## Usage

### Basic Usage

```dart
const AnimatedAnalogClock()
```

### Customization Options

```dart
AnimatedAnalogClock(
          location: 'Australia/Darwin',
          // Gradient Background if you want
          // backgroundGradient: RadialGradient(colors: []),
          backgroundColor: Color(0xff1E1E26),
          hourHandColor: Colors.lightBlueAccent,
          minuteHandColor: Colors.lightBlueAccent,
          secondHandColor: Colors.amber,
          centerDotColor: Colors.amber,
          hourIndicatorColor: Colors.lightBlue,
          minuteIndicatorColor: Colors.blueAccent,
        ),
```

### API Documentation

For detailed information about the classes and methods available in this package, refer to the [`API documentation`](https://pub.dev/documentation/animated_analog_clock/latest/).

### Example

More examples can be found in the [`example/`](https://github.com/MuhammadHasan-Git/animated_analog_clock/tree/main/example/lib) folder.

### License

This package is distributed under the MIT License. See the [`LICENSE`](LICENSE) file for details.

### Contact

For questions, feedback, or suggestions regarding this package, please feel free to contact the author at [devhasanzaman@gmail.com](mailto:devhasanzaman@gmail.com).
