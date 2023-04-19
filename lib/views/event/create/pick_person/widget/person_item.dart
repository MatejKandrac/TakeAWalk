
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';

class PersonItem extends StatelessWidget {
  const PersonItem(this.person, {Key? key, this.selected = false, required this.onTap}) : super(key: key);
  final SearchPersonResponse person;
  final bool selected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: selected ? const Color(0xffF20AB8) : null,
        borderRadius: BorderRadius.circular(15)
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: person.picture == null ?
              const Icon(Icons.account_circle, size: 60) :
              Image.network("${AppConstants.baseUrl}/v1/pictures/${person.picture!}"),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.username,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (person.bio != null) Text(
                    person.bio!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xff9d9d9d)
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
