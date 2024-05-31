import 'dart:async';
import 'dart:io';
import 'package:core/core.dart';
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
import 'package:dio/dio.dart';

class MetaClubApiClient {
  final String token;
  final String companyUrl;
  late final HttpServiceImpl _httpServiceImpl;

  MetaClubApiClient({required this.token, required this.companyUrl}) {
    _httpServiceImpl = HttpServiceImpl(token: token);
  }

  static const rootUrl = 'https://www.24hourworx.com';

  static const _baseUrl = '$rootUrl/api/V11/';

  String getBaseUrl() {
    final baseUrl = companyUrl;
    return baseUrl;
  }

  Future<Either<Failure, LoginData?>> login(
      {required String email,
      required String password,
      String? deviceId,
      String? deviceInfo,
      required String? baseUrl}) async {
    const String login = 'login';

    final body = {'email': email, 'password': password, "device_id": deviceId, "device_info": deviceInfo};

    try {
      final response = await _httpServiceImpl.postRequest('${baseUrl ?? _baseUrl}$login', body);
      return response.fold((l) {
        return Left(l);
      }, (r) {
        return right(LoginData.fromJson(r.data));
      });
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<bool> logout({required String baseUrl, String? token}) async {
    const String logout = 'logout';
    final response = await _httpServiceImpl.getRequestWithToken('$baseUrl$logout', token: token);

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Either<Failure, RegistrationData>> registration({bodyData}) async {
    const String register = 'register';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$register', bodyData);

      return response.fold((l) {
        return Left(l);
      }, (r) {
        return Right(RegistrationData.fromJson(r.data));
      });
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<CompanyListModel?> getCompanyList() async {
    const String api = '$rootUrl/api/V11/company-list';
    try {
      final response = await _httpServiceImpl.getRequestWithToken(api);
      if (response?.statusCode == 200) {
        return CompanyListModel.fromJson(response?.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<Settings?> getSettings() async {
    const String api = 'app/base-settings';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');
      if (response?.statusCode == 200) {
        return Settings.fromJson(response?.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<Either<Failure, SupportListModel?>> getSupport(String type, String month) async {
    const String api = 'support-ticket/list';
    final data = {"type": type, "month": month};

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(SupportListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, CheckData?>> checkInOut({required Map<String, dynamic> body}) async {
    const String api = 'user/attendance';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', body);
      return response.fold(
        (l) => Left(l),
        (r) => Right(CheckData.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> offlineCheckInOut({required Map<String, dynamic> body}) async {
    const String api = 'user/attendance/offline';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', body);
      return response.fold(
        (l) => Left(l),
        (r) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, AttendanceReport?>> getAttendanceReport(
      {required Map<String, dynamic> body, int? userId}) async {
    final String api = 'report/attendance/particular-month/$userId';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', body);
      return response.fold(
        (l) => Left(l),
        (r) => Right(AttendanceReport.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, Break?>> backBreak() async {
    const String api = 'user/attendance/break-back';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', {});
      return response.fold(
        (l) => Left(l),
        (r) => Right(Break.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<DashboardModel?> getDashboardData() async {
    const String api = 'dashboard/statistics';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode == 200) {
        return DashboardModel.fromJson(response?.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<Either<Failure, LeaveDetailsModel?>> leaveReportDetailsApi(int? userId, int leaveId) async {
    const String api = 'user/leave/details';

    try {
      final data = {"user_id": userId};
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api/$leaveId', data);

      return response.fold((l) => Left(l), (r) => Right(LeaveDetailsModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveReportTypeWiseSummary?>> getLeaveSummaryTypeWise(data) async {
    const String api = 'report/leave/date-wise-leave';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(LeaveReportTypeWiseSummary.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure,LeaveSummaryModel?>> leaveSummaryApi(int? userId) async {
    const String api = 'user/leave/summary';

    try {
      final formData = {
        "user_id": userId,
      };
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold((l) => Left(l), (r) => Right(LeaveSummaryModel.fromJson(r.data)));
    } on Exception catch (e) {
      return left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveReportSummaryModel?>> leaveReportSummaryApi(String date) async {
    const String api = 'report/leave/date-summary';
    final data = {'date': date};

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(LeaveReportSummaryModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveDetailsModel?>> leaveDetailsApi(int? userId, int? requestId) async {
    final String api = "user/leave/details/$requestId";

    try {
      final data = {"user_id": userId};
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(LeaveDetailsModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<bool> cancelLeaveRequest(int? requestId) async {
    String api = 'user/leave/request/cancel/$requestId';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode == 200) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<Either<Failure, bool>> submitLeaveRequestApi({BodyCreateLeaveModel? bodyCreateLeaveModel}) async {
    const String api = 'user/leave/request';
    if (kDebugMode) {
      print(bodyCreateLeaveModel?.toJson());
    }
    try {
      final formData = FormData.fromMap(bodyCreateLeaveModel!.toJson());
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (_) => Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> cancelVisitApi({BodyVisitCancel? bodyVisitCancel}) async {
    const String api = 'visit/change-status';
    if (kDebugMode) {
      print(bodyVisitCancel?.toJson());
    }
    try {
      final formData = FormData.fromMap(bodyVisitCancel!.toJson());
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (_) => Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createRescheduleApi({BodyCreateSchedule? bodyCreateSchedule}) async {
    const String api = 'visit/create-schedule';
    if (kDebugMode) {
      print(bodyCreateSchedule?.toJson());
    }
    try {
      final formData = FormData.fromMap(bodyCreateSchedule!.toJson());
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (_) => Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> visitUploadImageApi({BodyImageUpload? bodyImageUpload}) async {
    const String api = 'visit/image-upload';
    if (kDebugMode) {
      print(bodyImageUpload?.toJson());
    }
    try {
      final formData = FormData.fromMap(bodyImageUpload!.toJson());
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (_) => Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> updateVisitApi({BodyUpdateVisit? bodyUpdateVisit}) async {
    const String api = 'visit/update';

    if (kDebugMode) {
      print(bodyUpdateVisit?.toJson());
    }
    try {
      FormData formData = FormData.fromMap(bodyUpdateVisit!.toJson());
      await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return const Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> visitCreateNoteApi({BodyVisitNote? bodyVisitNote}) async {
    const String api = 'visit/create-note';

    if (kDebugMode) {
      print(bodyVisitNote?.toJson());
    }
    try {
      FormData formData = FormData.fromMap(bodyVisitNote!.toJson());
      await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return const Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createConferenceApi({CreateConferenceBodyModel? conferenceBodyModel}) async {
    const String api = "conference/create";

    try {
      FormData formData = FormData.fromMap(conferenceBodyModel!.toJson());
      await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return const Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createMeetingApi({MeetingBodyModel? meetingBodyModel}) async {
    const String api = "meeting/create";

    try {
      FormData formData = FormData.fromMap(meetingBodyModel!.toJson());
      await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createVisitApi({BodyCreateVisit? bodyCreateVisit}) async {
    const String api = 'visit/create';

    if (kDebugMode) {
      print(bodyCreateVisit?.toJson());
    }
    try {
      FormData formData = FormData.fromMap(bodyCreateVisit!.toJson());
      await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveRequestTypeModel>> leaveRequestTypeApi(int? userId) async {
    const String api = 'user/leave/available';

    try {
      FormData formData = FormData.fromMap({"user_id": userId});
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold((l) => Left(l), (r) => Right(LeaveRequestTypeModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, DailyLeaveSummaryModel?>> dailyLeaveSummary(int? userId, String? date) async {
    const String api = 'daily-leave/leave-list';
    try {
      FormData formData = FormData.fromMap({"user_id": userId, "date": date});
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (r) => Right(DailyLeaveSummaryModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveTypeListModel?>> dailyLeaveSummaryStaffView({
    String? userId,
    String? month,
    String? leaveType,
    String? leaveStatus,
  }) async {
    const String api = 'daily-leave/staff-list-view';
    try {
      FormData formData = FormData.fromMap({
        "user_id": userId,
        "month": month,
        "leave_type": leaveType,
        "leave_status": leaveStatus,
      });
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (r) => Right(LeaveTypeListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, dynamic>> postApplyLeave(data) async {
    const String api = 'daily-leave/store';
    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, dynamic>> dailyLeaveApprovalAction(data) async {
    const String api = 'daily-leave/approve-reject';
    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, Profile?>> getProfile() async {
    const String api = 'user/profile-info';
    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', {});
      return response.fold(
        (l) => Left(l),
        (r) => Right(Profile.fromJson(r.data['data'])),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createSupportApi({required data}) async {
    String api = 'user/profile/update/';

    try {
      debugPrint('body: $data');

      FormData formData = FormData.fromMap(data);

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (_) {
      return Left(ExceptionFailure(exception: _));
    }
  }

  Future<Either<Failure, bool>> updateProfile({required String slag, required data}) async {
    String api = 'user/profile/update/$slag';

    try {
      debugPrint('body: $data');

      FormData formData = FormData.fromMap(data);

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (_) => Right(true),
      );
    } on Exception catch (_) {
      return Left(ExceptionFailure(exception: _));
    }
  }

  Future<Either<Failure, bool>> createSupport({BodyCreateSupport? bodyCreateSupport}) async {
    String api = 'support-ticket/add';

    try {
      debugPrint('body: $bodyCreateSupport');

      FormData formData = FormData.fromMap({
        "subject": bodyCreateSupport?.subject,
        "description": bodyCreateSupport?.description,
        "image_url": bodyCreateSupport?.previewId,
        "priority_id": bodyCreateSupport?.priorityId,
      });

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (_) {
      return Left(ExceptionFailure(exception: _));
    }
  }

  Future<Either<Failure, bool>> updateProfileAvatar({required int avatarId}) async {
    String api = 'user/profile-update';

    try {
      debugPrint('body: ${{"avatar_id": avatarId}}');

      FormData formData = FormData.fromMap({"avatar_id": avatarId});

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (_) => Right(true),
      );
    } on Exception catch (_) {
      return Left(ExceptionFailure(exception: _));
    }
  }

  Future<Either<Failure, FileUpload?>> uploadFile({required File file}) async {
    const String api = 'file-upload';

    try {
      FormData formData = FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (r) => Right(FileUpload.fromJson(r.data)),
      );
    } on Exception catch (_) {
      return Left(ExceptionFailure(exception: _));
    }
  }

  Future<ContactsSearchList?> contactsSearchList() async {
    const String api = 'user/search?name=';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode != 200) {
        throw ContactRequestFailure();
      }
      return ContactsSearchList.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  /// Live Location store API -----------------
  Future<Either<Failure, bool>> storeLocationToServer({
    required List<Map<String, dynamic>> locations,
    String? date,
  }) async {
    try {
      final data = {'locations': locations, 'date': date};
      var response = await _httpServiceImpl.postRequest(
        "${getBaseUrl()}user/attendance/live-location-store",
        data,
      );
      return response.fold(
        (l) => Left(l),
        (_) => Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Notices?> notices() async {
    const String api = 'notices/get-list';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

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
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

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
      final response = await _httpServiceImpl.getRequest('${getBaseUrl()}$api');

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

  Future<Either<Failure, dynamic>> postEventGoing(data) async {
    const String api = 'events/going';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (_) {
      return Left(ExceptionFailure(exception: _));
    }
  }

  Future<Either<Failure, dynamic>> postEventAppreciate(data) async {
    const String api = 'events/appreciate';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (_) {
      return Left(ExceptionFailure(exception: _));
    }
  }

  Future<Either<Failure, dynamic>> postUserApproval(data) async {
    const String api = 'user/approval';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (_) {
      return Left(ExceptionFailure(exception: _));
    }
  }

  Future<Directories?> directories() async {
    const String api = 'club/all-directory-list';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

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
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

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
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return BirthListModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<Either<Failure, dynamic>> postBirthDayWish(data) async {
    const String api = 'birthday/message/store';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ResponseUserList?>> getUserList(data) async {
    const String api = 'list-users';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(ResponseUserList.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<AnniversaryModel?> getAnniversaries() async {
    const String api = 'anniversary/get-list';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return AnniversaryModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<GetUserByIdResponse?> getUserById(int? userId) async {
    const String api = 'user/';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api$userId');

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
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

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
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return DonationModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  ///================== Acts & Regulation ===================
  Future<ActsRegulationModel?> actsRegulation() async {
    const String api = 'content/act-regulations';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

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
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

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
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api/$noticeId');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return ResponseNoticeDetails.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<Either<Failure, NoticeListModel?>> getNoticeList() async {
    const String api = 'notice/list';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', '');

      return response.fold(
        (l) => Left(l),
        (r) => Right(NoticeListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<ResponseAllContents?> getPolicyData(String? slug) async {
    const String api = 'app/all-contents/';

    try {
      final response = await _httpServiceImpl.getRequestWithToken(
        '${getBaseUrl()}$api$slug',
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

    final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$clear');

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  ///// All Notification ///////////
  Future<bool> clearNoticeApi() async {
    const String clear = 'notice/clear';

    final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$clear');

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// ================== Phonebook ====================
  Future<Phonebook?> getPhoneBooks(
      {String? keywords, int? designationId, int? departmentId, required int pageCount}) async {
    // String api = 'app/get-all-users/33?keywords=$keywords';
    String api =
        'app/get-all-employees?search=${keywords ?? ''}&designation_id=${designationId ?? ''}&department_id=${departmentId ?? ''}&page=$pageCount';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return Phonebook.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  /// ================== Phonebook Details====================
  Future<PhoneBookDetailsModel?> getPhoneBooksUserDetails({String? userId}) async {
    String api = 'user/details/$userId';
    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return PhoneBookDetailsModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  /// ===================== Task Dashboard Data ========================
  Future<TaskDashboardModel?> getTaskInitialData({String? statuesId = '26'}) async {
    String api = 'tasks?status=$statuesId';
    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

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
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return TaskDetailsModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<Either<Failure, bool>> updateTaskStatusAndSlider({data}) async {
    const String api = 'tasks/update';

    try {
      FormData formData = FormData.fromMap(data);

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (r) => Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, MeetingsListModel?>> getMeetingsItem(String month) async {
    const String api = 'appoinment/get-list';
    final data = {"month": month};

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(MeetingsListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ResponseExpenseList?>> getExpenseItem(
      String month, String? paymentType, String? status) async {
    const String api = 'accounts/expense/list';
    final data = {"month": month, "payment": paymentType, "status": status};

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(ResponseExpenseList.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, BreakReportModel?>> getBreakHistory(
    String date,
  ) async {
    const String api = 'user/attendance/break-history';
    final data = {"date": date};

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(BreakReportModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<ExpenseCategoryModel?> getExpenseCategory() async {
    String api = 'accounts/expense/category-list';
    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return ExpenseCategoryModel.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<Either<Failure, String>> appointmentCreate({AppointmentBody? appointmentBody}) async {
    String api = 'appoinment/create';

    try {
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

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data['message']),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure,LeaveRequestModel?>> leaveRequestApi(int? userId, String? date) async {
    const String api = 'user/leave/list/view';

    try {
      final data = {"user_id": userId, "month": date};
      final response =
      await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold((l) => Left(l), (r) => Right(LeaveRequestModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, VerificationCodeModel>> forgetPassword({ForgotPasswordBody? forgotPasswordBody}) async {
    String api = 'change-password';

    try {
      final data = {
        "email": forgotPasswordBody?.email,
        "code": forgotPasswordBody?.code,
        "password": forgotPasswordBody?.password,
        "password_confirmation": forgotPasswordBody?.passwordConfirmation
      };

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(VerificationCodeModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, VerificationCodeModel>> updatePassword({PasswordChangeBody? passwordChangeBody}) async {
    String api = 'user/password-update';

    try {
      final data = {
        "user_id": passwordChangeBody?.userId,
        "current_password": passwordChangeBody?.currentPassword,
        "password": passwordChangeBody?.password,
        "password_confirmation": passwordChangeBody?.passwordConfirmation,
      };

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(VerificationCodeModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, VerificationCodeModel>> getVerificationCode({String? email}) async {
    String api = 'reset-password';

    try {
      final data = {"email": email};

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(VerificationCodeModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ExpenseCreateResponse>> expenseCreate({ExpenseCreateBody? expenseCreateBody}) async {
    String api = 'expense/add';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', expenseCreateBody?.toJson());

      return response.fold(
        (l) => Left(l),
        (r) => Right(ExpenseCreateResponse.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, PayrollModel?>> getPayrollData({required String year}) async {
    const String api = 'report/payslip/list';

    final data = {"year": year.toString()};

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(PayrollModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ApprovalModel?>> getApprovalData() async {
    const String api = 'user/leave/approval/list/view';
    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', '');
      return response.fold(
        (l) => Left(l),
        (r) => Right(ApprovalModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Visit Details API
  Future<VisitDetailsModel?> getVisitDetailsApi(int? visitID) async {
    String api = 'visit/show/$visitID';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');
      if (response?.statusCode == 200) {
        return VisitDetailsModel.fromJson(response?.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// History List API
  Future<Either<Failure, HistoryListModel?>> getHistoryList(String? month) async {
    const String api = 'visit/history';

    final data = {"month": month};

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(HistoryListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Visit List ========================
  Future<VisitListModel?> getVisitList() async {
    const String api = 'visit/list';
    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');
      if (response?.statusCode == 200) {
        return VisitListModel.fromJson(response?.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// ===================== Meeting List ========================
  Future<Either<Failure, MeetingsListModel?>> getMeetingList(String? month) async {
    const String api = 'meeting';
    final data = {"month": month};
    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold((l) => Left(l), (r) => Right(MeetingsListModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ================== Approval Details====================
  Future<Either<Failure, ApprovalDetailsModel?>> getApprovalListDetails(
      {required String approvalId, required String approvalUserId}) async {
    String api = 'user/leave/details/$approvalId';
    final data = {"user_id": approvalUserId};
    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);

      return response.fold((l) => Left(l), (r) => Right(ApprovalDetailsModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ================== Action Approval Approved or Reject ====================
  Future<Either<Failure, bool>> approvalApprovedOrReject({required String approvalId, required int type}) async {
    String api = 'user/leave/approval/status-change/$approvalId/$type';
    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');

      if (response?.data['result'] != true) {
        throw NetworkRequestFailure(response?.data['message'] ?? 'server error');
      }
      return response?.data['result'];
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Summary of attendance  ------------------
  Future<Either<Failure, ReportAttendanceSummary?>> getAttendanceReportSummary(
      {required Map<String, dynamic> body}) async {
    String api = 'report/attendance/date-summary';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', body);
      return response.fold((l) => Left(l), (r) => Right(ReportAttendanceSummary.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Single Attendance Summary to List  ------------------
  Future<Either<Failure, SummaryAttendanceToList?>> getAttendanceSummaryToList(
      {required Map<String, dynamic> body}) async {
    String api = 'report/attendance/summary-to-list';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', body);
      return response.fold((l) => Left(l), (r) => Right(SummaryAttendanceToList.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Report Break Summary  ------------------
  Future<Either<Failure, ReportBreakSummaryModel?>> getBreakSummary({required Map<String, dynamic> body}) async {
    String api = 'report/break/date-summary';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', body);
      return response.fold((l) => Left(l), (r) => Right(ReportBreakSummaryModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Report Break List Summary  ------------------
  Future<Either<Failure, ReportBreakListModel?>> getBreakSummaryList({required Map<String, dynamic> body}) async {
    String api = 'report/break/user-break-history';

    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', body);
      return response.fold((l) => Left(l), (r) => Right(ReportBreakListModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Conference List  ------------------
  Future<ConferenceModel?> getConferenceList() async {
    const String api = 'conference/my-meeting';
    try {
      final response = await _httpServiceImpl.getRequestWithToken('${getBaseUrl()}$api');
      if (response?.statusCode == 200) {
        return ConferenceModel.fromJson(response?.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Check QR Code validations  ------------------
  Future<Either<Failure, bool>> checkQRValidations(data) async {
    const String api = 'user/attendance/qr-status';
    try {
      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);
      return response.fold((l) => Left(l), (r) => Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Face data store
  Future<Either<Failure, bool>> faceDataStore({String? faceData}) async {
    String api = 'check-face-data';

    try {
      final data = {"face_data": faceData};

      final response = await _httpServiceImpl.postRequest('${getBaseUrl()}$api', data);

      return response.fold((l) => Left(l), (r) => Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }
}
