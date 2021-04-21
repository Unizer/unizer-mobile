import 'package:flutter/material.dart';
import 'package:unizer/app/colors/unizer_colors.dart';

class ProgressLine extends StatefulWidget {
  const ProgressLine({Key? key, this.totalSteps, this.stepIndex, this.color})
      : super(key: key);
  final int? totalSteps;
  final int? stepIndex;
  final Color? color;

  @override
  _ProgressLineState createState() => _ProgressLineState();
}

class _ProgressLineState extends State<ProgressLine> {
  double lineWidth = 0;

  @override
  Widget build(BuildContext context) {
    lineWidth = ((widget.stepIndex! / widget.totalSteps!) / 100) * 100;

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      height: 4.0,
      color: widget.color ?? UniColors.progressLine,
      width: MediaQuery.of(context).size.width * lineWidth,
    );
  }
}
