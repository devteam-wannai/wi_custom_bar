import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wi_custom_bar/src/values/circle_value.dart';
import 'package:wi_custom_bar/src/values/const_value.dart';

import 'colors/tp_colors.dart';

class TemperatureVerticalBar extends StatefulWidget {
  final int maxIndex;
  final int currentIndex;
  final Color? baseBgColor;
  final Color? gradientBottomColor;
  final Color? gradientTopColor;
  final double? barWidth;
  final double? barHeight;
  final double? circleSize;
  final int? barPointCount;
  final bool showCountView;

  const TemperatureVerticalBar(
    this.maxIndex,
    this.currentIndex,
  {Key? key,
    this.baseBgColor = TPColors.baseBgColor,
    this.gradientBottomColor = TPColors.baseGradientBottomColor,
    this.gradientTopColor = TPColors.baseGradientTopColor,
    this.barWidth,
    this.barHeight,
    this.circleSize,
    this.barPointCount,
    this.showCountView = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TemperatureVerticalBar();
}

class _TemperatureVerticalBar extends State<TemperatureVerticalBar> {
  double? _barWidth;
  double? _barHeight;
  double? _circleSize;

  @override
  void initState() {

    if (mounted) {
      setState(() {
        _barWidth = widget.barWidth ?? ConstValue.baseVerticalWidth;
        _barHeight = widget.barHeight ?? ConstValue.baseVerticalHeight;
        _circleSize = widget.circleSize ?? CircleValue.size;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(width: _circleSize!);
  }

  Widget _buildBody({double width = CircleValue.size}) {
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: width * 1.5,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      _buildBarBg(width: _barWidth!, height: _barHeight!),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          _buildCircle(circleSize: _circleSize!),
                          _buildCircle(circleSize: _circleSize! * 0.9, bgColor: widget.gradientBottomColor),
                          _buildCircle(circleSize: _circleSize! / 3, bgColor: widget.baseBgColor)
                        ],
                      )
                  ),
                  Positioned(
                      child: _buildBar(width: _barWidth! ,height: _barHeight! * (widget.currentIndex > widget.maxIndex ? 1 : (widget.currentIndex / widget.maxIndex * 100 / 100)))
                  ),
                  Positioned(
                      left: 0, top: 0, bottom: 0,
                      child: SizedBox(
                        height: (_barHeight ?? ConstValue.baseVerticalHeight) + (_circleSize ?? CircleValue.size),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildBarPointLine(),
                        ),
                      )
                  )
                ],
              ),
            ),
            _buildCount()
          ],
        )
      ],
    );
  }

  _buildCount() {
    return !widget.showCountView ? const SizedBox() : Padding(
        padding: const EdgeInsets.only(bottom: 10,),
        child: Text('${widget.currentIndex}/${widget.maxIndex}'),
    );
  }

  _buildBar({double width = ConstValue.baseVerticalWidth, double height = ConstValue.baseVerticalHeight}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(CircleValue.radius), topRight: Radius.circular(CircleValue.radius)),
            gradient: LinearGradient(colors: [widget.gradientBottomColor!, widget.gradientTopColor!], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
          width: width / 1.8,
          height: height - (height / 2),
        ),
        AnimatedContainer(
          decoration: BoxDecoration(
            color: widget.gradientBottomColor!,
          ),
          margin: EdgeInsets.only(bottom: _circleSize ?? CircleValue.size),
          width: width / 1.8,
          height: height / 2,
          duration: const Duration(seconds: 1),
        ),
      ],
    );
  }

  _buildBarPointLine() {
    List<Widget> list = [];
    int barPointCount = widget.barPointCount ?? ((_barHeight ?? ConstValue.baseVerticalHeight) < 100 ? 4 : 7);

    for (int i=0; i<barPointCount; i++) {
      list.add(Container(
        margin: EdgeInsets.only(top: 3, bottom: 4, left: (_circleSize! - (_barWidth! / 1.8))),
        width: (_barWidth ?? ConstValue.baseVerticalWidth) * 0.25,
        height: 1.5,
        color: widget.baseBgColor!.withOpacity(0.8),
        child: const SizedBox(),
      ));
    }

    return list;
  }

  _buildBarBg({double width = ConstValue.baseVerticalWidth, double height = ConstValue.baseVerticalHeight}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(CircleValue.radius), topRight: Radius.circular(CircleValue.radius)),
            border: Border.all(width: 6, color: widget.baseBgColor!)
          ),
          width: width * 0.95,
          height: height + (_circleSize ?? CircleValue.size) - 2,
        ),
      ],
    );
  }

  _buildCircle({double circleSize = CircleValue.size, Color? bgColor}) => Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(CircleValue.radius)),
      color: bgColor ?? widget.baseBgColor,
      border: Border.all(width: bgColor == null ? 5 : 0, color: bgColor ?? widget.baseBgColor!)
    ),
    child: SizedBox(width: circleSize, height: circleSize,),
  );

}