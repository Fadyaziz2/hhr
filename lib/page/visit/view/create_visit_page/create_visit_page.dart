import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/bloc/authentication_bloc.dart';

class CreateVisitPage extends StatelessWidget {
  const CreateVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          tr("create_visit"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 4),
              child: Text(
                tr("employee"),
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title:
                Text(user?.user?.name ?? ""),
                subtitle: Text(
                    user?.user?.email ?? ""),
                leading: ClipOval(
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl: "${user?.user?.avatar}",
                    placeholder: (context, url) => Center(
                      child: Image.asset("assets/images/placeholder_image.png"),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}
