import 'package:flutter/material.dart';
import 'package:take_a_walk_app/widget/app_button.dart';

class ImagePickChoice extends StatelessWidget {
  const ImagePickChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: const Color(0xff222131),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: AppButton.outlined(
                height: double.infinity,
                outlineColor: const Color(0xffffffff),
                onPressed: () => Navigator.of(context).pop(true),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.image),
                    Text(
                      "From gallery",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: AppButton.outlined(
                height: double.infinity,
                outlineColor: const Color(0xffffffff),
                onPressed: () => Navigator.of(context).pop(false),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.camera),
                    Text(
                      "New picture",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
