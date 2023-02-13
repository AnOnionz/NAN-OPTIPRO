import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import '../../core/common/constants.dart';
class LoadingText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const LoadingText({Key? key, required this.text, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text, style: style ?? kStyleBlack16Regular,),
        const SizedBox(width: 2,),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: JumpingDotsProgressIndicator(
            color: style !=null ? Colors.white : Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
