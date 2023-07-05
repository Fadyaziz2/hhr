library meta_club_api;

import 'dart:io';

import 'package:dio_service/dio_service.dart';
import 'package:flutter/foundation.dart';
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

  static const _rootUrl = 'https://hrm.onestweb.com';

  static const _baseUrl = '$_rootUrl/api/V11/';

  Future<LoginData?> login(
      {required String email, required String password}) async {
    const String login = 'login';

    final body = {'email': email, 'password': password};

    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$login', body);

      print('response ${response.data}');

      if (response.statusCode != 200) {
        throw LoginRequestFailure();
      }
      return LoginData.fromJson(response.data);
    } catch (_) {
      return null;
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
      print(e.toString());
      return null;
    }
  }

  Future<Settings?> getSettings() async {
    const String api = 'app/base-settings';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');
      if (response?.statusCode == 200) {
        return Settings.fromJson(response?.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<CheckInOut?> checkInOut() async {
    const String api = 'user/attendance';

    try {
      final response = await _httpServiceImpl.getRequestWithToken('$_baseUrl$api');
      if (response?.statusCode == 200) {
        return CheckInOut.fromJson(response?.data['data']);
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

  Future<bool> updateProfile({required String slag, required data}) async {
    String api = 'user/profile/update/$slag';

    try {

      debugPrint('body: $data');

      FormData formData = FormData.fromMap(data);

      final response = await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

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

      debugPrint('body: ${{"avatar_id":avatarId}}');

      FormData formData = FormData.fromMap({"avatar_id":avatarId});

      final response = await _httpServiceImpl.postRequest('$_baseUrl$api', formData);

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

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path)
      });

      final response = await _httpServiceImpl.postRequest('$_baseUrl$api',formData);

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
}
