import 'package:flutter/material.dart';
import '../../core/common/constants.dart';


enum ActionType {black, white, transparent}

class ActionButton extends StatelessWidget {
  final String title;
  final ActionType type;
  final VoidCallback onPressed;
  final List<Color> colors;

  const ActionButton({Key? key, required this.title, required this.onPressed, required this.colors, this.type = ActionType.white}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: type == ActionType.transparent ? BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 1, color: const Color(0XFFACACAC))
        ): BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors)),
        child: Center(
            child: Text(
              title,
              style: type == ActionType.black ? kStyleBlack16Medium : kStyleWhite16Medium,
            )),
      ),
    );
  }
}

