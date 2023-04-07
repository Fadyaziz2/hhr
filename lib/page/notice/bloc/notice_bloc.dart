import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notice_event.dart';

part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {

  final MetaClubApiClient clubApiClient;

  NoticeBloc({required this.clubApiClient})
      : super(const NoticeState(status: NetworkStatus.initial)) {
    on<NoticeLoadRequest>(_onNoticeDataRequest);
  }

  _onNoticeDataRequest(NoticeLoadRequest event, Emitter<NoticeState> emit) async {
    emit(const NoticeState(status: NetworkStatus.loading));
    try {
      final notice = await clubApiClient.notices();
      emit(NoticeState(notices: notice, status: NetworkStatus.success));
    } catch (_) {
      emit(const NoticeState(status: NetworkStatus.failure));
    }
  }
}
