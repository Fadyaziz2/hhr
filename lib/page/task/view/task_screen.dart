import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/task/view/content/content.dart';
import '../bloc/task_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
        create: (_) => TaskBloc(
            metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
          ..add(TaskInitialDataRequest()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Task'),
          ),
          body: const TaskScreenContent(),
        ));
  }
}
