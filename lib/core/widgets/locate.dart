import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../../core/widgets/loading_text.dart';

class Locate extends StatelessWidget {
  Locate({Key? key}) : super(key: key);

  late final RiveAnimationController _controller = SimpleAnimation('map');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 300,
          width: 300,
          child: RiveAnimation.asset(
            'assets/images/location.riv',
            controllers: [_controller],
            fit: BoxFit.cover,
            // Update the play state when the widget's initialized
          ),
        ),
        const LoadingText(text: "Đang định vị"),
      ],
    );
  }
}
