import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';
import '../../../res/date_utils.dart';

part 'support_event.dart';
part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  final MetaClubApiClient _metaClubApiClient;

  SupportBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const SupportState(status: NetworkStatus.initial)) {
    on<GetSupportData>(_onSupportLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<OnFilterUpdate>(_onFilterChange);
  }

  FutureOr<void> _onSupportLoad(GetSupportData event, Emitter<SupportState> emit) async {

    final currentDate = DateFormat('y-MM').format(DateTime.now());

    emit(SupportState(status: NetworkStatus.loading,filter: event.filter,currentMonth: event.date));

    try {
      final success = await _metaClubApiClient.getSupport(getSelectedIndex(filter: state.filter),state.currentMonth ?? currentDate);
      if (success != null) {
        emit(SupportState(status: NetworkStatus.success, supportListModel: success,filter: event.filter,currentMonth: event.date));
      } else {
        emit(SupportState(status: NetworkStatus.failure,filter: event.filter,currentMonth: event.date));
      }
    } catch (e) {
      emit(SupportState(status: NetworkStatus.failure,filter: event.filter,currentMonth: event.date));
      throw NetworkRequestFailure(e.toString());
    }
  }

  String getSelectedIndex({required Filter filter}){
    late String selectedIndex;
    switch(state.filter){
      case Filter.open:
        selectedIndex = '12';
        break;
      case Filter.close:
        selectedIndex = '13';
        break;
      case Filter.all:
        selectedIndex = '';
        break;
      default:
        selectedIndex = '12';
    }
    return selectedIndex;
  }

  FutureOr<void> _onSelectDatePicker(SelectDatePicker event, Emitter<SupportState> emit) async {
    final date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM',dateTime: date!);
    add(GetSupportData(filter: state.filter,date: currentMonth));
  }

  FutureOr<void> _onFilterChange(OnFilterUpdate event, Emitter<SupportState> emit) {
    emit(state.copy(filter: event.filter));

    add(GetSupportData(filter: event.filter,date: event.date));
  }
}
