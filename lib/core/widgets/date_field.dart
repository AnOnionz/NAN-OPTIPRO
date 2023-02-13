// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../core/common/constants.dart';

class DateField extends StatefulWidget {
  final double width;
  final VoidCallback onTap;
  final TextEditingController controller;

  const DateField(
      {Key? key,
      required this.width,
      required this.onTap,
      required this.controller})
      : super(key: key);

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          'Thời gian',
          style: kStyleGrey14Regular,
        ),
      ),
      SizedBox(
        height: 50,
        width: widget.width,
        child: TextFormField(
          readOnly: true,
          style: const TextStyle(fontSize: 16),
          controller: widget.controller,
          onTap: widget.onTap,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
            suffixIcon: const Icon(
              Icons.date_range_outlined,
              size: 25,
              color: Colors.black45,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(.8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffeaeaea), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Color(0xffeaeaea), width: 2),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffeaeaea), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              gapPadding: double.infinity,
            ),
          ),
        ),
      ),
    ]);
  }
}
