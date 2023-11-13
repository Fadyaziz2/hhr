class LeaveListModel {
  String userId;
  String month;
  String leaveStatus;
  String leaveType;

  LeaveListModel(
      {required this.userId,
      required this.month,
      required this.leaveStatus,
      required this.leaveType});
}

/*
userId: state.selectEmployee?.id.toString() ?? event.userId,
month: state.currentMonth,
leaveStatus: event.leaveStatus,
leaveType: event.leaveType
*/
