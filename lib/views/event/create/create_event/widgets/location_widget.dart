
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key, required this.location, this.onDelete, this.isReorder = true}) : super(key: key);
  final Location location;
  final Function(Location location)? onDelete;
  final bool isReorder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: Text(
              location.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall
            ),
          ),
          const SizedBox(width: 5),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sunny),
              if (onDelete != null) InkWell(
                onTap: () => onDelete!(location),
                child: const Icon(Icons.delete_outline),
              ),
              if (isReorder) const SizedBox(width: 30)
            ],
          )
        ],
      ),
    );
  }

}
