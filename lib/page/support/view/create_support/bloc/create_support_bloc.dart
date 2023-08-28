
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/support/bloc/support_bloc.dart';
import 'package:onesthrm/res/enum.dart';

import 'create_support_event.dart';

class CreateSupportBloc extends Bloc<CreateSupportEvent, SupportState> {
  final MetaClubApiClient _metaClubApiClient;

  CreateSupportBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient, super(const SupportState(status: NetworkStatus.initial)){

  }

}