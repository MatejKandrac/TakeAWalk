
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
    this.capitalizeText = false
  }) : super(key: key);

  final String? errorText;
  final Widget? icon;
  final String? labelText;
  final bool obscureText;
  final bool capitalizeText;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        textInputAction: inputAction,
        keyboardType: inputType,
        obscureText: obscureText,
        textCapitalization:  capitalizeText ? TextCapitalization.words : TextCapitalization.none,
        decoration: InputDecoration(
          label: labelText == null ? null : Text(labelText!),
          errorText: errorText,
          suffixIcon: icon,
        )
    );
  }
}
