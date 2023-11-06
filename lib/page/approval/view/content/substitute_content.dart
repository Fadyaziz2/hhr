import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubstituteContent extends StatelessWidget {
  const SubstituteContent({
    super.key,
    required this.data,
  });

  final ApprovalDetailsData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 0.5),
              bottom: BorderSide(color: Colors.grey.shade300, width: 0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Substitute',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: const Color(0xFF6B6A70))),
          const SizedBox(
            height: 4,
          ),
          data?.substitute != null ?
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data?.substitute?.avatar ?? ''),
              ),
              title: Text(data?.substitute?.name ?? '',
                  style: Theme.of(context).textTheme.bodySmall),
              subtitle: Text(data?.substitute?.designation ?? ''),
            ),
          ) :  Text('N/A', style: Theme.of(context).textTheme.titleSmall)
        ],
      ),
    );
  }
}
