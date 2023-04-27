
import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({
    Key? key,
    required this.name,
    required this.onRequestHeaders,
    required this.onImageUrl,
    this.bio,
    this.picture,
    this.suffix,
    this.onDelete}) : super(key: key);

  final String name;
  final String? bio;
  final String? picture;
  final Function()? onDelete;
  final Map<String, String> Function() onRequestHeaders;
  final String Function(String base) onImageUrl;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff27283D),
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: picture == null
                      ? const Icon(Icons.account_circle, size: 40) :
                      Image.network(
                          onImageUrl(picture!),
                        headers: onRequestHeaders(),
                      ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall
                ))
              ],
            ),
          ),
          if (onDelete != null) Material(
            color: const Color(0xff27283D),
            child: IconButton(
                onPressed: onDelete!,
                icon: const Icon(Icons.delete)
            ),
          ),
          if (suffix != null) suffix!
        ],
      ),
    );
  }
}
