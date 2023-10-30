import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class LeaveState extends Equatable {
  final NetworkStatus status;
  final LeaveSummaryModel? leaveSummaryModel;
  final LeaveRequestModel? leaveRequestModel;
  final LeaveRequestTypeModel? leaveRequestType;
  final AvailableLeaveType? selectedRequestType;
  final String? startDate;
  final String? endDate;
  final String? currentMonth;
  final PhoneBookUser? selectedEmployee;

  const LeaveState(
      {this.status = NetworkStatus.initial,
      this.leaveSummaryModel,
      this.leaveRequestModel,
      this.leaveRequestType,
      this.selectedRequestType,
      this.startDate,
      this.selectedEmployee,
      this.endDate,
      this.currentMonth});

  LeaveState copyWith(
      {LeaveSummaryModel? leaveSummaryModel,
      NetworkStatus? status,
      LeaveRequestModel? leaveRequestModel,
      LeaveRequestTypeModel? leaveRequestType,
      AvailableLeaveType? selectedRequestType,
      String? startDate,
      String? currentMonth,
      final PhoneBookUser? selectedEmployee,
      String? endDate}) {
    return LeaveState(
        leaveSummaryModel: leaveSummaryModel ?? this.leaveSummaryModel,
        leaveRequestModel: leaveRequestModel ?? this.leaveRequestModel,
        leaveRequestType: leaveRequestType ?? this.leaveRequestType,
        selectedRequestType: selectedRequestType ?? this.selectedRequestType,
        startDate: startDate ?? this.startDate,
        selectedEmployee: selectedEmployee ?? this.selectedEmployee,
        endDate: endDate ?? this.endDate,
        currentMonth: currentMonth ?? this.currentMonth);
  }

  @override
  List<Object?> get props => [
        status,
        leaveSummaryModel,
        leaveRequestModel,
        leaveRequestType,
        selectedRequestType,
        startDate,
        endDate,
        selectedEmployee,
        currentMonth
      ];
}
