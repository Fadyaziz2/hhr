part of 'support_bloc.dart';

class SupportState extends Equatable {
  final NetworkStatus? status;
  final SupportListModel? supportListModel;
  final Filter filter;
  final String? currentMonth;

  const SupportState(
      {this.status,
      this.supportListModel,
      this.filter = Filter.open,
      this.currentMonth});

  SupportState copy(
      {NetworkStatus? status,
      SupportListModel? supportListModel,
      Filter? filter,
      String? currentMonth}) {
    return SupportState(
        status: status ?? this.status,
        supportListModel: supportListModel ?? this.supportListModel,
        filter: filter ?? this.filter,
    currentMonth: currentMonth ?? this.currentMonth);
  }

  @override
  List<Object?> get props => [status, supportListModel, filter,currentMonth];
}
