import 'dart:io';
import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';

abstract class HRMCoreBaseService {
  Future<Either<Failure, LoginData?>> login(
      {required String email, required String password,String? deviceId, String? deviceInfo});

  Future<Failure> logout();

  Future<Either<Failure, RegistrationData>> registration({bodyData});

  Future<Either<Failure, SupportListModel?>> getSupport(String type, String month);

  Future<Either<Failure, CheckData?>> checkInOut({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> offlineCheckInOut({required Map<String, dynamic> body});

  Future<Either<Failure, AttendanceReport?>> getAttendanceReport({required Map<String, dynamic> body, int? userId});

  Future<Either<Failure, Break?>> backBreak();

  Future<Either<Failure, LeaveDetailsModel?>> leaveReportDetailsApi(int? userId, int leaveId);

  Future<Either<Failure, LeaveReportTypeWiseSummary?>> getLeaveSummaryTypeWise(data);

  Future<Either<Failure,LeaveSummaryModel?>> leaveSummaryApi(int? userId);

  Future<Either<Failure, LeaveReportSummaryModel?>> leaveReportSummaryApi(String date);

  Future<Either<Failure, LeaveDetailsModel?>> leaveDetailsApi(int? userId, int? requestId);

  Future<Either<Failure, bool>> submitLeaveRequestApi({BodyCreateLeaveModel? bodyCreateLeaveModel});

  Future<Either<Failure, bool>> cancelVisitApi({BodyVisitCancel? bodyVisitCancel});

  Future<Either<Failure, bool>> createRescheduleApi({BodyCreateSchedule? bodyCreateSchedule});

  Future<Either<Failure, bool>> visitUploadImageApi({BodyImageUpload? bodyImageUpload});

  Future<Either<Failure, bool>> updateVisitApi({BodyUpdateVisit? bodyUpdateVisit});

  Future<Either<Failure, bool>> visitCreateNoteApi({BodyVisitNote? bodyVisitNote});

  Future<Either<Failure, bool>> createConferenceApi({CreateConferenceBodyModel? conferenceBodyModel});

  Future<Either<Failure, bool>> createMeetingApi({MeetingBodyModel? meetingBodyModel});

  Future<Either<Failure, bool>> createVisitApi({BodyCreateVisit? bodyCreateVisit});

  Future<Either<Failure, LeaveRequestTypeModel>> leaveRequestTypeApi(int? userId);

  Future<Either<Failure, DailyLeaveSummaryModel?>> dailyLeaveSummary(int? userId, String? date);

  Future<Either<Failure, LeaveTypeListModel?>> dailyLeaveSummaryStaffView({
    String? userId,
    String? month,
    String? leaveType,
    String? leaveStatus,
  });

  Future<Either<Failure, dynamic>> postApplyLeave(data);

  Future<Either<Failure, dynamic>> dailyLeaveApprovalAction(data);

  Future<Either<Failure, Profile?>> getProfile();

  Future<Either<Failure, bool>> createSupportApi({required data});

  Future<Either<Failure, bool>> updateProfile({required String slag, required data});

  Future<Either<Failure, bool>> createSupport({BodyCreateSupport? bodyCreateSupport});

  Future<Either<Failure, bool>> updateProfileAvatar({required int avatarId});

  Future<Either<Failure, FileUpload?>> uploadFile({required File file});

  Future<Either<Failure, bool>> storeLocationToServer({
    required List<Map<String, dynamic>> locations,
    String? date,
  });

  Future<Either<Failure, dynamic>> postEventGoing(data);

  Future<Either<Failure, dynamic>> postEventAppreciate(data);

  Future<Either<Failure, dynamic>> postUserApproval(data);

  Future<Either<Failure, dynamic>> postBirthDayWish(data);

  Future<Either<Failure, ResponseUserList?>> getUserList(data);

  Future<Either<Failure, NoticeListModel?>> getNoticeList();

  Future<Either<Failure, bool>> updateTaskStatusAndSlider({data});

  Future<Either<Failure, MeetingsListModel?>> getMeetingsItem(String month);

  Future<Either<Failure, ResponseExpenseList?>> getExpenseItem(
      String month, String? paymentType, String? status);

  Future<Either<Failure, BreakReportModel?>> getBreakHistory(
      String date,
      );

  Future<Either<Failure, String>> appointmentCreate({AppointmentBody? appointmentBody});

  Future<Either<Failure,LeaveRequestModel?>> leaveRequestApi(int? userId, String? date);

  Future<Either<Failure, VerificationCodeModel>> forgetPassword({ForgotPasswordBody? forgotPasswordBody});

  Future<Either<Failure, VerificationCodeModel>> updatePassword({PasswordChangeBody? passwordChangeBody});

  Future<Either<Failure, VerificationCodeModel>> getVerificationCode({String? email});

  Future<Either<Failure, ExpenseCreateResponse>> expenseCreate({ExpenseCreateBody? expenseCreateBody});

  Future<Either<Failure, PayrollModel?>> getPayrollData({required String year});

  Future<Either<Failure, ApprovalModel?>> getApprovalData();

  Future<Either<Failure, HistoryListModel?>> getHistoryList(String? month);

  Future<Either<Failure, MeetingsListModel?>> getMeetingList(String? month);

  Future<Either<Failure, ApprovalDetailsModel?>> getApprovalListDetails(
      {required String approvalId, required String approvalUserId});

  Future<Either<Failure, bool>> approvalApprovedOrReject({required String approvalId, required int type});

  Future<Either<Failure, ReportAttendanceSummary?>> getAttendanceReportSummary(
      {required Map<String, dynamic> body});

  Future<Either<Failure, SummaryAttendanceToList?>> getAttendanceSummaryToList(
      {required Map<String, dynamic> body});

  Future<Either<Failure, ReportBreakSummaryModel?>> getBreakSummary({required Map<String, dynamic> body});

  Future<Either<Failure, ReportBreakListModel?>> getBreakSummaryList({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> checkQRValidations(data);

  Future<Either<Failure, bool>> faceDataStore({String? faceData});
}
