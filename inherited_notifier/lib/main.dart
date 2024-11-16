import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderInheritedNotifier(
        sliderData: sliderData,
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Slider(
                    value: SliderInheritedNotifier.of(context),
                    onChanged: (v) {
                      print(v);
                      sliderData.value = v;
                    }),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Opacity(
                      opacity: SliderInheritedNotifier.of(context),
            
                      child: Container(
                        color: Colors.yellow,
                        height: 250,
                      ),
                    ),
                    Opacity(
                      opacity: SliderInheritedNotifier.of(context),
            
                      child: Container(
                        color: Colors.blue,
                        height: 250,
                      ),
                    )
                  ].expandEqually().toList(),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() {
    return map((e) => Expanded(
          child: e,
        ));
  }
}

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier(
      {required Widget child, required SliderData sliderData, Key? key})
      : super(child: child, key: key, notifier: sliderData);

  static double of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
            ?.notifier
            ?.value ??
        0.0;
  }
}

final sliderData = SliderData();

class SliderData extends ChangeNotifier {
  double _value = 0.0;
  double get value => _value;
  set value(double newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }
}
