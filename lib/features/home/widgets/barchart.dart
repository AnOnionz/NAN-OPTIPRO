import 'dart:math';
import 'package:flutter/material.dart';


class BarChart extends StatelessWidget {
  final double value;
  final int kpi;
  const BarChart({Key? key,required this.value, required this.kpi}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final max = MediaQuery.of(context).size.height / 4.8;
    final double px = ((max/3*2 - (2 - value/kpi.toInt())*5) / kpi);
    final unit = px.isNaN ? 0.0 : px;

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(value.toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          Container(
            height: min(unit*value, max-25),
            width: 50,
            decoration: const BoxDecoration(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}