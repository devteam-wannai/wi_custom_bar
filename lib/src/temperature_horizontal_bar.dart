import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wi_custom_bar/src/values/circle_value.dart';
import 'package:wi_custom_bar/src/values/const_value.dart';

import 'colors/tp_colors.dart';

class TemperatureHorizontalBar extends StatefulWidget {
  final int maxIndex;
  final int currentIndex;
  final Color? baseBgColor;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? barWidth;
  final double? barHeight;
  final double? circleSize;
  final int? barPointCount;
  final bool showCountView;

  const TemperatureHorizontalBar(
    this.maxIndex,
    this.currentIndex,
      {Key? key,
    this.baseBgColor = TPColors.baseBgColor,
    this.gradientStartColor = TPColors.baseGradientBottomColor,
    this.gradientEndColor = TPColors.baseGradientTopColor,
    this.barWidth,
    this.barHeight,
    this.circleSize,
    this.barPointCount,
    this.showCountView = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TemperatureHorizontalBar();
}

class _TemperatureHorizontalBar extends State<TemperatureHorizontalBar> {
  double? _barWidth;
  double? _barHeight;
  double? _circleSize;

  @override
  void initState() {

    if (mounted) {
      setState(() {
        _barWidth = widget.barWidth ?? ConstValue.baseHorizontalWidth;
        _barHeight = widget.barHeight ?? ConstValue.baseHorizontalHeight;
        _circleSize = widget.circleSize ?? CircleValue.size;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(height: _circleSize!);
  }

  Widget _buildBody({double height = CircleValue.size}) {
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: height * 1.5,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      _buildBarBg(width: _barWidth!, height: _barHeight!),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      top: 0,
                      left: 0,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          _buildCircle(circleSize: _circleSize!),
                          _buildCircle(circleSize: _circleSize! * 0.9, bgColor: widget.gradientStartColor),
                          _buildCircle(circleSize: _circleSize! / 3, bgColor: widget.baseBgColor)
                        ],
                      )
                  ),
                  Positioned(
                      child: _buildBar(height: _barHeight! ,width: _barWidth! * (widget.currentIndex > widget.maxIndex ? 1 : (widget.currentIndex / widget.maxIndex * 100 / 100)))
                  ),
                  Positioned(
                      top: 0, left: 0, right: 0,
                      child: SizedBox(
                        width: (_barWidth ?? ConstValue.baseHorizontalWidth) + (_circleSize ?? CircleValue.size),
                        child: Row(
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
      padding: EdgeInsets.only(bottom: _circleSize! / 2, left: 5),
      child: Text('${widget.currentIndex}/${widget.maxIndex}'),
    );
  }

  _buildBar({double width = ConstValue.baseHorizontalWidth, double height = ConstValue.baseHorizontalHeight}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.gradientStartColor!,
          ),
          margin: EdgeInsets.only(left: _circleSize ?? CircleValue.size),
          width: width / 2,
          height: height / 1.8,
        ),
        AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(CircleValue.radius), topRight: Radius.circular(CircleValue.radius)),
            gradient: LinearGradient(colors: [widget.gradientStartColor!, widget.gradientEndColor!], begin: Alignment.centerLeft, end: Alignment.centerRight),
          ),
          width: width - (width / 2),
          height: height / 1.8,
          duration: const Duration(seconds: 1),
        ),
      ],
    );
  }

  _buildBarPointLine() {
    List<Widget> list = [];
    int barPointCount = widget.barPointCount ?? ((_barWidth ?? ConstValue.baseHorizontalWidth) < 100 ? 4 : 7);

    for (int i=0; i<barPointCount; i++) {
      list.add(Container(
        margin: EdgeInsets.only(top: (_circleSize! - (_barHeight! / 1.8)), right: 4, left: 5),
        width: 1.5,
        height: (_barHeight ?? ConstValue.baseHorizontalHeight) * 0.25,
        color: widget.baseBgColor!.withOpacity(0.8),
        child: const SizedBox(),
      ));
    }

    return list;
  }

  _buildBarBg({double width = ConstValue.baseHorizontalWidth, double height = (ConstValue.baseHorizontalHeight * 0.95)}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(CircleValue.radius), topRight: Radius.circular(CircleValue.radius)),
              border: Border.all(width: 6, color: widget.baseBgColor!)
          ),
          width: width + (_circleSize ?? CircleValue.size) - 5,
          height: height,
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