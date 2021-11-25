<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# StarlightThread

starlight_thread is a isolate that easy way to use isolate.

## Features

There is two way to use such as Steam version and Future version.

[Watch the video](https://fb.watch/9uDAyYJW_b/)

## Installation

Add responsive_builder as dependency to your pubspec file.

```dart
starlight_thread: 
    git:
      url: https://github.com/YeMyoAung/starlight_responsive_builder.git
```

## Usage

First of all you need to import our package.

```dart
import 'package:starlight_thread/starlight_thread.dart';
```

## Stream Version

```dart
import 'package:starlight_thread/starlight_thread.dart';

class Counter {
  final int value;
  Counter(this.value);
}

int heavyMethod(Counter counter) {
  int total = 0;
  for (var i = 0; i < counter.value; i++) {
    for (var a = 0; a < counter.value * i; a++) {
      for (var b = 0; b < counter.value * a; b++) {
        for (var c = 0; c < counter.value * b; c++) {
          for (var d = 0; d < counter.value * c; d++) {
            total += counter.value * d;
          }
        }
      }
    }
  }
  return total;
}

void main() {
    ///[StarlightThread] constructor [FutureOr] call back is required [bool] distinct is optional
    final StarlightThread<int, Counter> _thread =
        StarlightThread.prepare(callback: heavyMethod);
    ///to execute call back [Function]
    _thread.execute(Counter(100));

    ///data listener [Stream]
    _thread.stream.listen((isolateValue) {
      print("result is $isolateValue");
    }, onError: (isolateError) {
      print("error is $isolateError");
    });

    ///Another Way
    
    ///the whole result
    _thread.result;

    ///first data
    _thread.first;

    ///last data
    _thread.last;
}
```

## Future Version

```dart
import 'package:starlight_thread/starlight_thread.dart';

class Counter {
  final int value;
  Counter(this.value);
}

int heavyMethod(Counter counter) {
  int total = 0;
  for (var i = 0; i < counter.value; i++) {
    for (var a = 0; a < counter.value * i; a++) {
      for (var b = 0; b < counter.value * a; b++) {
        for (var c = 0; c < counter.value * b; c++) {
          for (var d = 0; d < counter.value * c; d++) {
            total += counter.value * d;
          }
        }
      }
    }
  }
  return total;
}

Future<void> main() async {
    ///[StarlightThread] static method [FutureOr] call back is required [T] data is required
    final int _thread =
        await StarlightThread.wait(callback: heavyMethod, data: Counter(100));
}
```

## Contact Us

[Starlight Studio](https://www.facebook.com/starlightstudio.of/)
