import 'package:flutter/material.dart';
import '../../../../core/common/constants.dart';

class CustomToast extends StatelessWidget {
  final String msg;
  final Color color;
  final Icon? icon;

  const CustomToast({Key? key,required this.msg, required this.color, this.icon}): super(key: key);



  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: icon ?? const SizedBox(),
          ),
          //msg
          Text(msg, style: kStyleWhite16Medium),
        ]),
      ),
    );
  }

}