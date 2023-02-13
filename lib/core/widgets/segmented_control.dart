import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/common/constants.dart';

class SegmentedControl extends StatefulWidget {
  final int segmentedControlValue;
  final Function(int value) onChanged;
  final Color? thumbColor;
  final String left;
  final String right;

  const SegmentedControl(
      {Key? key,
      required this.segmentedControlValue,
      required this.onChanged,
      this.thumbColor,
      required this.left,
      required this.right})
      : super(key: key);
  @override
  _SegmentedControlState createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10.0)),
        child: CupertinoSlidingSegmentedControl(
            groupValue: widget.segmentedControlValue,
            backgroundColor: Colors.transparent,
            thumbColor: widget.thumbColor ?? kGreenOpacityColor,
            children: <int, Widget>{
              0: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    widget.left,
                    style: widget.segmentedControlValue == 0
                        ? kStyleBlack16Regular
                        : kStyleWhite16Regular,
                  )),
              1: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(widget.right,
                      style: widget.segmentedControlValue == 0
                          ? kStyleWhite16Regular
                          : kStyleBlack16Regular)),
            },
            padding: const EdgeInsets.all(4.0),
            onValueChanged: (value) {
              setState(() {
                widget.onChanged(value as int);
              });
            }),
      ),
    );
  }
}
