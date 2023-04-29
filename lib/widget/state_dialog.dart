

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/widget/app_button.dart';

Future showStateDialog({required BuildContext context, required bool isSuccess, required String text, bool closeOnConfirm = false}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => _LottieDialog(
        contentText: text,
        asset: isSuccess ? AppAssets.success : AppAssets.error,
        closeOnConfirm: closeOnConfirm,
      )
  );
}

Future showLottieDialog({required BuildContext context, required String text, required String asset, bool closeOnConfirm = false}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => _LottieDialog(
          contentText: text,
          asset: asset,
          closeOnConfirm: closeOnConfirm
      ),
  );
}

class _LottieDialog extends HookWidget {
  const _LottieDialog({Key? key,
    required this.contentText,
    required this.asset,
    required this.closeOnConfirm
  }) : super(key: key);

  final String contentText;
  final String asset;
  final bool closeOnConfirm;

  _statusListener(AnimationStatus status, BuildContext context) async {
    if (status == AnimationStatus.completed && !closeOnConfirm) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController();
    useEffect(() {
      controller.addStatusListener((status) => _statusListener(status, context));
      return null;
    }, const []);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
              asset,
              height: 100,
              width: 100,
              fit: BoxFit.contain,
              controller: controller,
              onLoaded: (p0) {
                controller
                  ..duration = p0.duration
                  ..forward();
              },
              repeat: false),
          const SizedBox(height: 10),
          Text(contentText, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          if (closeOnConfirm) const SizedBox(height: 10),
          if (closeOnConfirm) AppButton.primary(
              child: Text("OK", style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () => Navigator.of(context).pop()
          )
        ],
      ),
    );
  }
}
