import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/notice_bloc.dart';
import 'content/notice_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({Key? key}) : super(key: key);

  static Route get route {
    return MaterialPageRoute(builder: (_) => const NoticePage());
  }

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (_) =>
          NoticeBloc(clubApiClient: MetaClubApiClient(token: '${user?.token}'))
            ..add(NoticeLoadRequest()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notice'),
          backgroundColor: mainColor,
        ),
        body: BlocBuilder<NoticeBloc, NoticeState>(
          builder: (context, state) {
            if (state.status == NetworkStatus.loading) {
              return Center(child: CircularProgressIndicator(color: mainColor,));
            }
            if (state.status == NetworkStatus.success) {
              final notices = state.notices;

              if (notices != null) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: NoticeContent(
                    notices: notices,
                  ),
                );
              }
              return const SizedBox();
            }
            if (state.status == NetworkStatus.failure) {
              return const Center(
                child: Text('Error to load'),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
