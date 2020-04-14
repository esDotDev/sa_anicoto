*This project is part of the [Simple Animations Framework](https://pub.dev/packages/simple_animations)*

# 🎥 Anicoto

Anicoto (**Ani**mation**Con**troller **to**olkit) enriches your developing expierience with Flutter's AnimationController. 


## 🌞 Highlights

- Configure animation in stateful widgets **within seconds**
- **Simplified** AnimationController handling

## ⛏ Usage

🛈 *The following code snippets use [**supercharged**](https://pub.dev/packages/supercharged) for syntactic sugar.*

### Getting started

Add **Simple Animations** to your project by following the instructions on the 
**[install page](https://pub.dev/packages/simple_animations#-installing-tab-)**.

To learn how to use Anicoto:

- Continue reading this page
- Study complete examples at
[**example page**](https://pub.dev/packages/sa_multi_tween#-example-tab-)
- Discover the
[**API documentation**](https://pub.dev/documentation/sa_multi_tween/latest/sa_multi_tween/sa_multi_tween-library.html)


### Basic usage pattern

#### Overview

Configuring animation support is always three simple steps:

- Add the `AnimationMixin` to the *State class* of your stateful widget
- Declare `Animation<?>` class variables for each tween and use them in the `build()` method
- Start using `controller` to wire `Animation<?>` class variables and call `controller.play()` inside the `initState()` method.

#### Three steps explained

Creating own animations with an `AnimationController` requires state changing. For that you first create a **stateful widget** that contains the content you want to animate.

Start by adding `with AnimationMixin` to your **state class**.
```dart
class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
    with AnimationMixin { // <-- add AnimationMixin to your state class

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0, // <-- value to animate
      height: 100.0, // <-- value to animate
      color: Colors.red
    );
  }
}
```
This snippet wants to animate a red square. For that we identified `width` and `height` to be the animated property "size".

Next we substitute the fixed values for our "size" with a declared `Animation<double>` class variable.

```dart
class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
    with AnimationMixin {

  Animation<double> size; // <-- Animation variable for "size"
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.value, // <-- use the animated value for "size"
      height: size.value, // <-- use the animated value for "size"
      color: Colors.red
    );
  }
}
```

