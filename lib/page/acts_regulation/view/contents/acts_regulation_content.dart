import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../res/enum.dart';
import '../../bloc/acts_regulation_bloc.dart';

class ActsRegulationContent extends StatelessWidget {
  const ActsRegulationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActsRegulationBloc, ActsRegulationState>(
      builder: (context, state) {
        if (state.networkStatus == NetworkStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: mainColor,
            ),
          );
        }
        if (state.networkStatus == NetworkStatus.success) {
          if (state.actsRegulationModel != null) {
            final data = state.actsRegulationModel!.data!;
            return SingleChildScrollView(child: Html(data: data.content));
          }
        }

        if (state.networkStatus == NetworkStatus.failure) {
          return const Center(
            child: Text('Error to load'),
          );
        }
        return const SizedBox();
      },
    );
  }
}
