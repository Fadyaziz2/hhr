import 'package:club_application/page/pending_request/bloc/pending_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import 'content/approval.dart';

class PaddingRequestPage extends StatelessWidget {
  const PaddingRequestPage({Key? key}) : super(key: key);
  static Route get route =>
      MaterialPageRoute(builder: (_) => const PaddingRequestPage());

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(create: (_) => PendingBloc(metaClubApiClient: MetaClubApiClient(token : "${user?.token}"))
    ..add(UserListLoadRequest()),
      child:  const ApprovalContent()
    );
  }
}
