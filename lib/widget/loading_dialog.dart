
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
    this.loadingText = "Loading..."
  }) : super(key: key);

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircularProgressIndicator(),
            Text(loadingText)
          ],
        ),
      ),
    );
  }
}
