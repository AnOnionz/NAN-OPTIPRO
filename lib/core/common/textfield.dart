import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

@immutable
// ignore: must_be_immutable
class InputField extends StatelessWidget {
  final bool isSBP6;
  final Function(String)? onSubmit;
  final String? subText;
  final bool? enable;
  final String? hint;
  final FocusNode? thisFocus;
  final FocusNode? nextFocus;
  final TextInputAction? action;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputType? inputType;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String)? onChanged;

  const InputField({Key? key, this.onChanged, this.enable = true, this.onSubmit, this.subText,  this.textAlign , this.controller, this.hint,this.action, this.textCapitalization, this.inputType, this.thisFocus, this.nextFocus, this.inputFormatter, this.isSBP6 = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      focusNode: thisFocus,
      textInputAction: action,
      textAlign: textAlign ?? TextAlign.start,
      autofocus: false,
      onFieldSubmitted: nextFocus != null ?  (v) {
        FocusScope.of(context).requestFocus(nextFocus!);
      } : onSubmit,
      controller: controller,
      onChanged: onChanged,
      style: textInput,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: inputType,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        suffixIcon: subText !=null ? SizedBox(
          width: 80,
          child: Align(
            alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  subText!,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 17),
                ),
              )),
        ) : null,
        suffixStyle: const TextStyle(color: Colors.black),
        hintText: hint,
        hintStyle: hintText,
        contentPadding: const EdgeInsets.all(15.0),
        filled: true,
        fillColor: enable!= null && enable == false ? const Color(0xFFF0F0F0) : Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: isSBP6 ? const BorderSide(color: Colors.yellow, width: 2) : const BorderSide(color: Color(0xFFC5C5C5), width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: isSBP6 ? const BorderSide(color: Colors.yellow, width: 2) : const BorderSide(color: Color(0xFFC5C5C5), width: 1),
        ),
        disabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: isSBP6 ? const BorderSide(color: Colors.yellow, width: 2) : const BorderSide(color: Color(0xFFC5C5C5), width: 1),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gapPadding: double.infinity,
        ),
      ),
    );
  }
}
