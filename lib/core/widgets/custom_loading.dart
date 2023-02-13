import 'package:flutter/material.dart';
import 'package:rive_loading/rive_loading.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RiveLoading(
      name: 'assets/images/loading.riv',
      startAnimation: 'Animation 1',
      loopAnimation: 'Animation 1',
      onSuccess: (data) {
      },
      onError: (error, stacktrace) {
      },
    );
  }
}
