library meta_club_api;

import 'dart:io';
import 'package:dio_service/dio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:meta_club_api/src/models/anniversary.dart';
import 'package:meta_club_api/src/models/birthday.dart';
import 'package:meta_club_api/src/models/contact_search.dart';
import 'package:meta_club_api/src/models/gallery.dart';
import 'package:meta_club_api/src/models/more.dart';
import 'package:meta_club_api/src/models/response_qualification.dart';
import 'package:user_repository/user_repository.dart';
import 'models/acts_regulation.dart';
import 'models/content.dart';
import 'models/donation.dart';
import 'models/election_info.dart';
import 'package:dio/dio.dart';

class MetaClubApiClient {
  String token;
  late final HttpServiceImpl _httpServiceImpl;

  MetaClubApiClient({required this.token}) {
    _httpServiceImpl = HttpServiceImpl(token: token);
  }

  static const rootUrl = 'https://api.onesttech.com';

  static const _baseUrl = '$rootUrl/api/2.0/';

  Future<Either<LoginFailure, LoginData?>> login(
      {required String email, required String password}) async {
    const String login = 'login';

    final body = {'email': email, 'password': password};

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$login', body);

      if (response.statusCode != 200) {
        throw LoginRequestFailure();
      }
      return right(LoginData.fromJson(response.data));
    } catch (e) {
      return Left(LoginFailure(error: e.toString()));
    }
  }

  Future<bool> deleteAccount() async {
    const String delete = 'delete-account';

    final response =
        await _httpServiceImpl.getRequestWithToken('$_baseUrl$delete');

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<RegistrationData?> registration({bodyData}) async {
    const String register = 'register';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$register', bodyData);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw LoginRequestFailure();
      }
      return RegistrationData.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<Settings?> getSettings() async {
    const String api = 'app/base-settings';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');
      if (response?.statusCode == 200) {
        return Settings.fromJson(response?.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<SupportListModel?> getSupport(String type, String month) async {
    const String api = 'support-ticket/list';

    final data = {"type": type, "month": month};

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);
      if (response.statusCode == 200) {
        return SupportListModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<CheckData?> checkInOut({required Map<String, dynamic> body}) async {
    const String api = 'user/attendance';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', body);
      if (response.statusCode == 200) {
        return CheckData.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// attendance report get data ------------------
  Future<AttendanceReport?> getAttendanceReport(
      {required Map<String, dynamic> body, int? userId}) async {
    String api = 'report/attendance/particular-month/$userId';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', body);
      if (response.statusCode == 200) {
        return AttendanceReport.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<Break?> backBreak() async {
    const String api = 'user/attendance/break-back';
    try {
      final response = await _httpServiceImpl.postRequest('$_baseUrl$api', {});
      if (response.statusCode == 200) {
        return Break.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<DashboardModel?> getDashboardData() async {
    const String api = 'dashboard/statistics';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode == 200) {
        return DashboardModel.fromJson(response?.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<LeaveSummaryModel?> leaveSummaryApi(int? userId) async {
    const String api = 'user/leave/summary';

    try {
      FormData formData = FormData.fromMap({
        "user_id": userId,
      });
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return LeaveSummaryModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<SelectEmployeeLeaveModel?> selectEmployeeLeaveSummaryApi(
      int? userId) async {
    const String api = 'user/leave/list/view';

    try {
      FormData formData = FormData.fromMap({
        "user_id": userId,
      });
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return SelectEmployeeLeaveModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<LeaveRequestModel?> leaveRequestApi(int? userId, String? date) async {
    const String api = 'user/leave/list/view';

    try {
      final data = {"user_id": userId, "month": date};
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode == 200) {
        return LeaveRequestModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<LeaveDetailsModel?> leaveReportDetailsApi(
      int? userId, int leaveId) async {
    const String api = 'user/leave/details';

    try {
      final data = {"user_id": userId};
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api/$leaveId', data);
      if (response.statusCode == 200) {
        return LeaveDetailsModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<LeaveReportSummaryModel?> leaveReportSummaryApi(String date) async {
    const String api = 'report/leave/date-summary';
    final data = {'date': date};
    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode == 200) {
        return LeaveReportSummaryModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<LeaveDetailsModel?> leaveDetailsApi(
      int? userId, int? requestId) async {
    String api = "user/leave/details/$requestId";

    try {
      FormData formData = FormData.fromMap({"user_id": userId});
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return LeaveDetailsModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<bool> cancelLeaveRequest(int? requestId) async {
    String api = 'user/leave/request/cancel/$requestId';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode == 200) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> submitLeaveRequestApi(
      {BodyCreateLeaveModel? bodyCreateLeaveModel}) async {
    const String api = 'user/leave/request';

    if (kDebugMode) {
      print(bodyCreateLeaveModel?.toJson());
    }
    try {
      FormData formData = FormData.fromMap(bodyCreateLeaveModel!.toJson());
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<LeaveRequestTypeModel?> leaveRequestTypeApi(int? userId) async {
    const String api = 'user/leave/available';

    try {
      FormData formData = FormData.fromMap({"user_id": userId});
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return LeaveRequestTypeModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<DailyLeaveSummaryModel?> dailyLeaveSummary(
      int? userId, String? date) async {
    const String api = 'daily-leave/leave-list';

    try {
      FormData formData = FormData.fromMap({"user_id": userId, "month": date});
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return DailyLeaveSummaryModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<LeaveTypeListModel?> dailyLeaveSummaryStaffView(
      {String? userId,
      String? month,
      String? leaveType,
      String? leaveStatus}) async {
    const String api = 'daily-leave/staff-list-view';

    try {
      FormData formData = FormData.fromMap({
        "user_id": userId,
        "month": month,
        "leave_type": leaveType,
        "leave_status": leaveStatus
      });
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return LeaveTypeListModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future postApplyLeave(data) async {
    const String api = 'daily-leave/store';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return response.data;
    } catch (_) {
      return null;
    }
  }

  Future dailyLeaveApprovalAction(data) async {
    const String api = 'daily-leave/approve-reject';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return response.data;
    } catch (_) {
      return null;
    }
  }

  Future<Profile?> getProfile() async {
    const String api = 'user/profile-info';

    try {
      final response = await _httpServiceImpl.postRequest('$_baseUrl$api', {});

      if (response.statusCode == 200) {
        return Profile.fromJson(response.data['data']);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<bool> createSupportApi({required data}) async {
    String api = 'user/profile/update/';

    try {
      debugPrint('body: $data');

      FormData formData = FormData.fromMap(data);

      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateProfile({required String slag, required data}) async {
    String api = 'user/profile/update/$slag';

    try {
      debugPrint('body: $data');

      FormData formData = FormData.fromMap(data);

      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> createSupport({BodyCreateSupport? bodyCreateSupport}) async {
    String api = 'support-ticket/add';

    try {
      debugPrint('body: $bodyCreateSupport');

      FormData formData = FormData.fromMap({
        "subject": bodyCreateSupport?.subject,
        "description": bodyCreateSupport?.description,
        "file_id": bodyCreateSupport?.previewId,
        "priority_id": bodyCreateSupport?.priorityId
      });

      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateProfileAvatar({required int avatarId}) async {
    String api = 'user/profile-update';

    try {
      debugPrint('body: ${{"avatar_id": avatarId}}');

      FormData formData = FormData.fromMap({"avatar_id": avatarId});

      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<FileUpload?> uploadFile({required File file}) async {
    const String api = 'file-upload';

    try {
      FormData formData =
          FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});

      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return FileUpload.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  Future<ContactsSearchList?> contactsSearchList() async {
    const String api = 'user/search?name=';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw ContactRequestFailure();
      }
      return ContactsSearchList.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  /// Live Location store API -----------------
  Future<bool> storeLocationToServer(
      {required List<Map<String, dynamic>> locations, String? date}) async {
    try {
      final data = {'locations': locations};
      var response = await _httpServiceImpl.postRequest(
          "${_baseUrl}user/attendance/live-location-store", data);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("storeLocationToServer ${response.data}");
        }
        return true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        return false;
      } else {
        if (kDebugMode) {
          print(e.message);
        }
      }
    }
    return false;
  }

  Future<Notices?> notices() async {
    const String api = 'notices/get-list';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      switch (response?.statusCode) {
        case 200:
          return Notices.fromJson(response?.data);
        case 401:
          debugPrint('you are unauthorized');
          break;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  ///========================== Event =====================
  Future<Events?> events() async {
    const String api = 'events/get-list';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return Events.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  ///========================== More =====================
  Future<Mores?> mores() async {
    const String api = 'content/list';
    try {
      final response = await _httpServiceImpl.getRequest('$_baseUrl$api');

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return Mores.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  Future<Content?> getContent({required String slug}) async {
    try {
      final response = await _httpServiceImpl.getRequest(slug);
      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return Content.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  Future postEventGoing(data) async {
    const String api = 'events/going';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return response.data;
    } catch (_) {
      return null;
    }
  }

  Future postEventAppreciate(data) async {
    const String api = 'events/appreciate';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return response.data;
    } catch (_) {
      return null;
    }
  }

  Future postUserApproval(data) async {
    const String api = 'user/approval';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return response.data;
    } catch (_) {
      return null;
    }
  }

  Future<Directories?> directories() async {
    const String api = 'club/all-directory-list';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return Directories.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<Galleries?> galleries() async {
    const String api = 'events/gallery-photo';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return Galleries.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<BirthListModel?> getBirthdays() async {
    const String api = 'birthday/get-list?month=07';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return BirthListModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future postBirthDayWish(data) async {
    const String api = 'birthday/message/store';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return response.data;
    } catch (_) {
      return null;
    }
  }

  Future<ResponseUserList?> getUserList(data) async {
    const String api = 'list-users';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return ResponseUserList.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  Future<AnniversaryModel?> getAnniversaries() async {
    const String api = 'anniversary/get-list';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return AnniversaryModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future postAnniversaryWish(data) async {
    const String api = 'anniversary/message/store';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return response.data;
    } catch (_) {
      return null;
    }
  }

  Future<GetUserByIdResponse?> getUserById(int? userId) async {
    const String api = 'user/';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api$userId');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return GetUserByIdResponse.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<ResponseQualification?> getQualification() async {
    const String api = 'qualifications';
    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return ResponseQualification.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<DonationModel?> getDonations() async {
    const String api = 'donation/get-list';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return DonationModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future postAppreciated(data) async {
    const String api = 'donation/appreciate';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return response.data;
    } catch (_) {
      return null;
    }
  }

  ///================== Election Info data ===================

  Future<ElectionInfo?> getElectionInfo() async {
    const String api = 'election/info';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return ElectionInfo.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future postSubmitVote(data) async {
    const String api = 'election/store-vote';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);
      debugPrint(response.data.toString());
      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return response.data;
    } catch (_) {
      return null;
    }
  }

  ///================== Acts & Regulation ===================
  Future<ActsRegulationModel?> actsRegulation() async {
    const String api = 'content/act-regulations';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return ActsRegulationModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<NotificationResponse?> getNotification() async {
    const String api = 'user/notification';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return NotificationResponse.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<ResponseNoticeDetails?> getNotificationDetaisl(int noticeId) async {
    const String api = 'notice/show';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api/$noticeId');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return ResponseNoticeDetails.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<NoticeListModel?> getNoticeList() async {
    const String api = 'notice/list';

    try {
      final response = await _httpServiceImpl.postRequest('$_baseUrl$api', '');

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return NoticeListModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  Future<ResponseAllContents?> getPolicyData(String? slug) async {
    const String api = 'app/all-contents/';

    try {
      final response = await _httpServiceImpl.getRequestWithToken(
        '$_baseUrl$api$slug',
      );

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return ResponseAllContents.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

///// All Notification ///////////
  Future<bool> clearAllNotificationApi() async {
    const String clear = 'user/notification/clear';

    final response =
        await _httpServiceImpl.getRequestWithToken('$_baseUrl$clear');

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  ///// All Notification ///////////
  Future<bool> clearNoticeApi() async {
    const String clear = 'notice/clear';

    final response =
        await _httpServiceImpl.getRequestWithToken('$_baseUrl$clear');

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// ================== Phonebook ====================
  Future<Phonebook?> getPhoneBooks(
      {String? keywords,
      int? designationId,
      int? departmentId,
      required int pageCount}) async {
    // String api = 'app/get-all-users/33?keywords=$keywords';
    String api =
        'app/get-all-employees?search=${keywords ?? ''}&designation_id=${designationId ?? ''}&department_id=${departmentId ?? ''}&page=$pageCount';

    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return Phonebook.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  /// ================== Phonebook Details====================
  Future<PhoneBookDetailsModel?> getPhoneBooksUserDetails(
      {String? userId}) async {
    String api = 'user/details/$userId';
    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return PhoneBookDetailsModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  /// ===================== Task Dashboard Data ========================
  Future<TaskDashboardModel?> getTaskInitialData(
      {String statuesId = '26'}) async {
    String api = 'tasks?status=$statuesId';
    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return TaskDashboardModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  /// ===================== Tasks Details ========================
  Future<TaskDetailsModel?> getTaskDetails(String taskId) async {
    // String api = 'app/get-all-employees/$userId';
    String api = 'tasks/$taskId';
    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return TaskDetailsModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<bool> updateTaskStatusAndSlider({data}) async {
    const String api = 'tasks/update';

    try {
      FormData formData = FormData.fromMap(data);

      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<MeetingsListModel?> getMeetingsItem(String month) async {
    const String api = 'appoinment/get-list';

    final data = {"month": month};

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);
      if (response.statusCode == 200) {
        return MeetingsListModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<ResponseExpenseList?> getExpenseItem(
      String month, String? paymentType, String? status) async {
    const String api = 'accounts/expense/list';

    final data = {"month": month, "payment": paymentType, "status": status};

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);
      if (response.statusCode == 200) {
        return ResponseExpenseList.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<BreakReportModel?> getBreakHistory(
    String date,
  ) async {
    const String api = 'user/attendance/break-history';

    final data = {
      "date": date,
    };

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);
      if (response.statusCode == 200) {
        return BreakReportModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<ExpenseCategoryModel?> getExpenseCategory() async {
    String api = 'accounts/expense/category-list';
    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return ExpenseCategoryModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  ///////// Appoinment Create///////////////
  Future<String> appointmentCreate({AppointmentBody? appointmentBody}) async {
    String api = 'appoinment/create';

    try {
      // debugPrint('body: $data');

      FormData formData = FormData.fromMap({
        "title": appointmentBody?.title,
        "description": appointmentBody?.description,
        "appoinment_with": appointmentBody?.appointmentWith,
        "date": appointmentBody?.date,
        "location": appointmentBody?.location,
        "appoinment_start_at": appointmentBody?.appointmentStartDate,
        "appoinment_end_at": appointmentBody?.appointmentEndDate,
        "file_id": appointmentBody?.previewId,
      });

      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

      if (response.data['result'] == true) {
        return response.data['message'];
      }
      return response.data['message'];
    } catch (e) {
      return 'Something went wrong';
    }
  }

  Future<ExpenseCreateResponse> expenseCreate(
      {ExpenseCreateBody? expenseCreateBody}) async {
    String api = 'expense/add';
    try {
      final response = await _httpServiceImpl.postRequest(
          '$_baseUrl$api', expenseCreateBody?.toJson());
      return ExpenseCreateResponse.fromJson(response.data);
    } catch (e) {
      return ExpenseCreateResponse(
          message: 'Something went wrong', success: false);
    }
  }

  /// ===================== Payroll Data List ========================
  Future<PayrollModel?> getPayrollData({required String year}) async {
    const String api = 'report/payslip/list';

    final data = {"year": year.toString()};

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);
      if (response.statusCode == 200) {
        return PayrollModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// ===================== Payroll Data List ========================
  Future<ApprovalModel?> getApprovalData() async {
    const String api = 'user/leave/approval/list/view';
    try {
      final response = await _httpServiceImpl.postRequest('$_baseUrl$api', '');
      if (response.statusCode == 200) {
        return ApprovalModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// ================== Approval Details====================
  Future<ApprovalDetailsModel?> getApprovalListDetails(
      {required String approvalId, required String approvalUserId}) async {
    String api = 'user/leave/details/$approvalId';
    final data = {"user_id": approvalUserId};
    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', data);

      if (response.statusCode != 200) {
        throw NetworkRequestFailure(response.statusMessage ?? 'server error');
      }
      return ApprovalDetailsModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  /// ================== Action Approval Approved or Reject ====================
  Future approvalApprovedOrReject(
      {required String approvalId, required int type}) async {
    String api = 'user/leave/approval/status-change/$approvalId/$type';
    try {
      final response =
          await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');

      if (response?.data['result'] != true) {
        throw NetworkRequestFailure(
            response?.data['message'] ?? 'server error');
      }
      return response?.data['result'];
    } catch (_) {
      return null;
    }
  }

  /// Summary of attendance  ------------------
  Future<ReportAttendanceSummary?> getAttendanceReportSummary(
      {required Map<String, dynamic> body}) async {
    String api = 'report/attendance/date-summary';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', body);
      if (response.statusCode == 200) {
        return ReportAttendanceSummary.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Single Attendance Summary to List  ------------------
  Future<SummaryAttendanceToList?> getAttendanceSummaryToList(
      {required Map<String, dynamic> body}) async {
    String api = 'report/attendance/summary-to-list';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', body);
      if (response.statusCode == 200) {
        return SummaryAttendanceToList.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Report Break Summary  ------------------
  Future<ReportBreakSummaryModel?> getBreakSummary(
      {required Map<String, dynamic> body}) async {
    String api = 'report/break/date-summary';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', body);
      if (response.statusCode == 200) {
        return ReportBreakSummaryModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Report Break List Summary  ------------------
  Future<ReportBreakListModel?> getBreakSummaryList(
      {required Map<String, dynamic> body}) async {
    String api = 'report/break/user-break-history';

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$api', body);
      if (response.statusCode == 200) {
        return ReportBreakListModel.fromJson(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
