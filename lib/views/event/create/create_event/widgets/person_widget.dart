
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({Key? key, required this.profile, this.onDelete}) : super(key: key);
  final ProfileResponse profile;
  final Function(ProfileResponse profile)? onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: profile.image == null ? const Icon(Icons.account_circle) : Image.network(profile.image!),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(
                    profile.username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall
                ))
              ],
            ),
          ),
          if (onDelete != null)InkWell(
            onTap: () => onDelete!(profile),
            child: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}
