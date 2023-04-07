import 'package:club_application/page/directory/directory.dart';
import 'package:club_application/page/directory/view/content/directory_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

class DirectoryPage extends StatelessWidget {

  const DirectoryPage({Key? key}) : super(key: key);

  static Route get route {
    return MaterialPageRoute(builder: (_) => const DirectoryPage());
  }

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return Scaffold(
      appBar: AppBar(title: const Text('Directory'),backgroundColor: mainColor,),
      body: BlocProvider(
        create: (_) => DirectoryBloc(metaClubApiClient: MetaClubApiClient(token: '${user?.token}'))..add(DirectoryLoadRequest()),
        child: const DirectoryContent(),
      ),
    );
  }
}

