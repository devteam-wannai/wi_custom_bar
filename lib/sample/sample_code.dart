import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../wi_custom_bar.dart';

class SampleCode extends StatefulWidget {

  const SampleCode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SampleCode();
}

class _SampleCode extends State<SampleCode> {
  int? _currentIndex;
  int? _currentIndex2;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemperatureVerticalBar(10, _currentIndex ?? 1,
              showCountView: true,
            ),
            TemperatureHorizontalBar(10, _currentIndex2 ?? 1,
              gradientStartColor: Colors.blueAccent,
              gradientEndColor: Colors.yellowAccent,
              showCountView: true,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mounted) {
            setState(() {
              _currentIndex = Random().nextInt(11);
              _currentIndex2 = Random().nextInt(11);
            });
          }
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

}