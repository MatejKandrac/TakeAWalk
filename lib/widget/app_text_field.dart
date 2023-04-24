
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    this.errorText,
    this.icon,
    this.labelText,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.done,
    this.capitalizeText = false,
    this.maxLines,
    this.hint
  }) : super(key: key);

  final String? errorText;
  final Widget? icon;
  final String? labelText;
  final bool obscureText;
  final bool capitalizeText;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final String? hint;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        textInputAction: inputAction,
        keyboardType: inputType,
        obscureText: obscureText,
        textCapitalization:  capitalizeText ? TextCapitalization.words : TextCapitalization.none,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          label: labelText == null ? null : Text(labelText!),
          errorText: errorText,
          suffixIcon: icon,
          hintText: hint
        )
    );
  }
}
