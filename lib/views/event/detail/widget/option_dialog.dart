

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/widget/app_button.dart';

class QuestionDialog extends HookWidget {
  const QuestionDialog({
    Key? key,
    required this.text,
    required this.onAccept,
    required this.onDecline
  }) : super(key: key);

  final String text;
  final Function() onAccept;
  final Function() onDecline;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
              AppAssets.question,
              controller: controller,
              onLoaded: (p0) {
                controller
                  ..duration = p0.duration
                  ..forward();
              },
              repeat: false),
          const SizedBox(height: 10),
          Text(text, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: AppButton.secondary(
                    onPressed: onDecline,
                    child: Text("Cancel", style: Theme.of(context).textTheme.bodyMedium)
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton.primary(
                    onPressed: onAccept,
                    child: Text("Confirm", style: Theme.of(context).textTheme.bodyMedium)
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
