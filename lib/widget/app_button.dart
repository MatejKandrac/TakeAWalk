import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton.text({
    Key? key,
    required this.child,
    required this.onPressed,
    this.height = 55,
  })  : backgroundColor = Colors.transparent,
        gradient = null,
        outlineColor = null,
        radius = 30,
        super(key: key);

  const AppButton.secondary({
    Key? key,
    required this.child,
    required this.onPressed,
    this.height = 55,
    this.backgroundColor = const Color(0xff7740c2),
  })  : gradient = null,
        outlineColor = null,
        radius = 30,
        super(key: key);

  const AppButton.primary({
    Key? key,
    required this.child,
    required this.onPressed,
    this.height = 55,
    this.backgroundColor = const Color(0xffF20AB8),
  })  : gradient = null,
        outlineColor = null,
        radius = 30,
        super(key: key);

  const AppButton.gradient({
    Key? key,
    required this.child,
    required this.onPressed,
    this.gradient = const LinearGradient(
        colors: <Color>[Color(0xffF20AB8), Color(0xff6C30E8)]),
    this.height = 55,
  })  : outlineColor = null,
        radius = 30,
        backgroundColor = Colors.transparent,
        super(key: key);

  const AppButton.outlined({
    Key? key,
    required this.child,
    required this.outlineColor,
    required this.onPressed,
    this.radius = 30,
    this.height = 55,
    this.backgroundColor = Colors.transparent,
  })  : gradient = null,
        super(key: key);

  const AppButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      required this.backgroundColor,
      this.outlineColor,
      this.gradient,
      this.radius = 30,
      this.height = 55})
      : super(key: key);

  final double height;
  final Widget child;
  final LinearGradient? gradient;
  final Color? outlineColor;
  final Color backgroundColor;
  final double radius;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
        border: outlineColor == null
            ? null
            : Border.all(color: outlineColor!, width: 2),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return backgroundColor.withAlpha(100);
            } else {
              return backgroundColor;
            }
          }),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
        ),
        child: child,
      ),
    );
  }
}
