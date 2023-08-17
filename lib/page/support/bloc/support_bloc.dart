import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/support/bloc/support_event.dart';
import 'package:onesthrm/page/support/bloc/support_state.dart';
import 'package:onesthrm/res/enum.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  final MetaClubApiClient _metaClubApiClient;

  SupportBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const SupportState(status: NetworkStatus.initial)) {
    on<GetSupportData>(_onSupportLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onSupportLoad(
      GetSupportData event, Emitter<SupportState> emit) async {
    emit(const SupportState(status: NetworkStatus.loading));

    try {
      final success = await _metaClubApiClient.getSupport();
      if (success != null) {
        emit( SupportState(status: NetworkStatus.success,supportListModel: success));
      } else {
        emit(const SupportState(status: NetworkStatus.failure));
      }
    } catch (e) {
      emit(const SupportState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectDatePicker(SelectDatePicker event, Emitter<SupportState> emit) {



    // showMonthPicker(
    //   context: context,
    //   firstDate: DateTime(DateTime.now().year - 1, 5),
    //   lastDate: DateTime(DateTime.now().year + 1, 9),
    //   initialDate: DateTime.now(),
    //   locale: const Locale("en"),
    // ).then((date) {
    //   if (date != null) {
    //     selectedDate = date;
    //     currentMonth = DateFormat('y-MM').format(selectedDate!);
    //     monthYear = DateFormat('MMMM,y').format(selectedDate!);
    //     supportTicketApi();
    //     if (kDebugMode) {
    //       print(DateFormat('y-MM').format(selectedDate!));
    //     }
    //     notifyListeners();
    //   }
    // });
  }
}
