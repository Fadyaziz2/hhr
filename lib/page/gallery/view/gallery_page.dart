import 'package:club_application/page/authentication/bloc/authentication_bloc.dart';
import 'package:club_application/page/gallery/bloc/gallery_bloc.dart';
import 'package:club_application/page/gallery/view/content/gallery_content.dart';
import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  static Route get route =>
      MaterialPageRoute(builder: (_) => const GalleryPage());

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (BuildContext context) => GalleryBloc(
          clubApiClient: MetaClubApiClient(token: '${user?.token}'))..add(GalleryLoadRequest()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
          backgroundColor: mainColor,
        ),
        body: const GalleryContent())
      );
  }
}
