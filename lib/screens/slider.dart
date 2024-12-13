import 'dart:math';
import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

class Slider1 extends StatelessWidget {
  const Slider1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confirmation Slider Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Slider1HomePage(title: 'Confirmation Slider Example'),
    );
  }
}

class Slider1HomePage extends StatefulWidget {
  const Slider1HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Slider1HomePage> createState() => _Slider1HomePageState();
}

class _Slider1HomePageState extends State<Slider1HomePage> {
  final _controller = ActionSliderController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 24.0),
            ActionSlider.standard(
              rolling: true,
              width: 300.0,
              backgroundColor: Colors.black,
              reverseSlideAnimationCurve: Curves.easeInOut,
              reverseSlideAnimationDuration: const Duration(milliseconds: 500),
              toggleColor: Colors.purpleAccent,
              icon: const Icon(Icons.add),
              action: (controller) async {
                controller.loading(); //starts loading animation
                await Future.delayed(const Duration(seconds: 3));
                controller.success(); //starts success animation
                await Future.delayed(const Duration(seconds: 1));
                controller.reset(); //resets the slider
              },
              child: const Text('Rolling slider',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
