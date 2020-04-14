
# 📝 Examples

🛈 *Note: These examples uses **[supercharged](https://pub.dev/packages/supercharged)** for syntactic sugar.*

## Basic usage pattern

```dart
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

void main() => runApp(MaterialApp(home: Page()));

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: MyAnimatedWidget())),
    );
  }
}

class MyAnimatedWidget extends StatefulWidget {
  @override
  _MyAnimatedWidgetState createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
    with AnimationMixin {  // Add AnimationMixin to state class

  Animation<double> size; // Declare animation variable

  @override
  void initState() {
    size = 0.0.tweenTo(200.0).animatedBy(controller); // Connect tween and controller and apply to animation variable
    controller.play(); // Start the animation playback
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.value, // Use animation variable's value here 
      height: size.value, // Use animation variable's value here
      color: Colors.red
    );
  }
}
```

