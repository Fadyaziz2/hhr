part of 'appoinment_bloc.dart';

class AppoinmentState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;
  final MeetingsListModel? meetingsListData;

  const AppoinmentState(
      {this.status, this.currentMonth, this.meetingsListData});

  AppoinmentState copy(
      {NetworkStatus? status,
      String? currentMonth,
      MeetingsListModel? meetingsListData}) {
    return AppoinmentState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        meetingsListData: meetingsListData ?? this.meetingsListData);
  }

  @override
  List<Object?> get props => [status, currentMonth, meetingsListData];
}
