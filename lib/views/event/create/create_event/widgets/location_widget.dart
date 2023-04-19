
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key, required this.location, this.onDelete, this.isReorder = true}) : super(key: key);
  final Location location;
  final Function(Location location)? onDelete;
  final bool isReorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff27283D),
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 60,
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
          const SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onDelete != null) Material(
                color: const Color(0xff27283D),
                child: IconButton(
                    onPressed: () => onDelete!(location),
                    icon: const Icon(Icons.delete)
                ),
              ),
              const SizedBox(width: 10),
              if (isReorder) const Icon(Icons.reorder)
            ],
          )
        ],
      ),
    );
  }

}
