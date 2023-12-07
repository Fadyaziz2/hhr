import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/conference/conference.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/shimmers.dart';

class ConferenceContentScreen extends StatelessWidget {
  const ConferenceContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conference'.tr()),
      ),
      body: BlocBuilder<ConferenceBloc, ConferenceState>(
          builder: (context, state) {
        if (state.status == NetworkStatus.loading) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: TileShimmer(
                  isSubTitle: true,
                ),
              );
            },
          );
        } else {
          return const ConferenceList();
        }
      }),
    );
  }
}
