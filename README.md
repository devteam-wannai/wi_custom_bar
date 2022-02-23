![](https://cdn.jsdelivr.net/gh/devteam-wannai/wi_custom_bar/assets/github_title_img.png)

<br>

# About wi_custom_bar
[![Pub](https://img.shields.io/pub/v/wi_custom_bar.svg)](https://pub.dev/packages/wi_custom_bar)

"wi_custom_bar" is a custom bar widget that implements a thermometer gauge bar created by wannai team.

<br>
<br>

## Installing:
In your pubspec.yaml
```yaml
dependencies:
  wi_custom_bar: ^0.0.1
```
```dart
import 'package:wi_custom_bar/wi_custom_bar.dart';
```

<br>
<br>

## Basic Usage:
```dart
  TemperatureVerticalBar(10, 5),

  TemperatureHorizontalBar(10, 6)
```

<br>
<br>

## Where to use:

It can be used to show a certain mission or achievement rate.
For example, complete 10 missions of the day gauge 5/10.

<img src="https://cdn.jsdelivr.net/gh/devteam-wannai/wi_custom_bar/assets/sample_image.png" alt="sample image" width="300"/>

<br>
<br>

## How to use:

1. Enter the maximum gauge number and the current gauge number. (necessary)
* Enter the current gauge number not to exceed the maximum gauge number.

2. The current achievement count is displayed on the right side of the gauge bar. (Optional)
   Usage: showCountView: true (defalut: false)

3. For the gauge bar gradation color, input Color values from bottom to top and from left to right.
   (Optional, there is a default value.)
   Usage: gradientStartColor: Colors.blueAccent, gradientEndColor: Colors.yellowAccent,

4. Adjustable gauge bar up and down, left and right length and round size
   (option)

<br>

## Custom Usage:
|  Properties  |   Description   |
|--------------|-----------------|
| `maxIndex` | Maximum value of gauge bar. |
| `currentIndex` | Current value of gauge bar. |
| `baseBgColor` | Default border and gauge ruler color around the gauge bar. `(default: white)`. |
| `gradientBottomColor or gradientStartColor` | Gauge bar gradient `start` color. |
| `gradientTopColor or gradientEndColor` | Gauge bar gradient `end` color. |
| `barWidth` | gauge bar thickness. |
| `barHeight` | gauge bar height. |
| `barPointCount` | number of gauge bar rulers. |
| `showCountView` | Gauge bar maximum and minimum count display `(marked position: lower right)`. |

<br>

##### Sample code ([Source Code](https://github.com/devteam-wannai/wi_custom_bar/blob/master/lib/sample/sample_code.dart))


