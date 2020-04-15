import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sa_anicoto/sa_anicoto.dart';
import 'package:supercharged/supercharged.dart';

void main() {
  testWidgets("builder", (WidgetTester tester) async {
    Text text;

    var animation = MaterialApp(home: TestWidget());

    await tester.pumpWidget(animation);
    await tester.pump(100.milliseconds);

    expect(find.text("0 0"), findsOneWidget);

    await tester.pump(100.days);

    expect(find.text("10 10"), findsOneWidget);
  });
}

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with AnimationMixin {
  Animation<int> a;
  Animation<int> b;

  @override
  void initState() {
    a = 0.tweenTo(10).animatedBy(controller..play(duration: 100.days));
    b = 0.tweenTo(10).animatedBy(createController()..play(duration: 100.days));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${a.value} ${b.value}"),
    );
  }
}
