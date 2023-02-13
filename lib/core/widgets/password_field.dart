import 'package:flutter/material.dart';

import '../common/constants.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback? onChange;

  PasswordField({Key? key,required this.label, required this.controller, this.focusNode, this.onChange}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  static const _borderRadius = 12.0;
  static const _borderColor = Color(0xFFB8B8D2);
  bool isObscure = true;

  void _toggle() {
    setState(() {
      isObscure = !isObscure;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: kStyleGrey14Regular,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            focusNode: widget.focusNode,
            textInputAction: TextInputAction.done,
            obscureText: isObscure,
            obscuringCharacter: "•",
            controller: widget.controller,
            onChanged: (value) {

            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'nhập mật khẩu ',
              hintStyle: kStyleGrey14Regular,
              contentPadding: const EdgeInsets.all(12),
              suffixIcon: InkWell(
                radius: 12,
                onTap: _toggle,
                child: isObscure ? Image.asset('assets/images/eye.png', width: 24,) : Image.asset('assets/images/eye1.png', width: 24,),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(.8),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: _borderColor, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: _borderColor, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: _borderColor, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
                gapPadding: double.infinity,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
