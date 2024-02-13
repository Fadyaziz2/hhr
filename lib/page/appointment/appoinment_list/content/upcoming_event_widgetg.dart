import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:equatable/equatable.dart';

class LoginData {
  final String? token;
  final User? user;
  final bool? result;
  final String? message;

  LoginData({this.token, this.user, this.result, this.message});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
        token: json['token'],
        user: User.fromJson(json['data']),
        result: json['result'],
        message: json["message"]);
  }
}

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final int? isActive;
  final int? isRejected;
  final int? isVerified;
  final int? roleId;
  final String? organization;
  final String? bloodGroup;
  final String? anniversary;
  final String? mailingAddress;
  final String? permanentAddress;
  final String? gender;
  final String? birthDate;
  final String? fatherName;
  final String? motherName;
  final String? nationality;
  final String? passportNumber;
  final String? religion;
  final String? maritalStatus;
  final String? tin;
  final String? bankName;
  final String? bankAccount;
  final String? emergencyName;
  final String? emergencyMobileNumber;
  final String? emergencyMobileRelationship;
  final String? userGroup;
  final String? message;

  // final String? avatar;

  const User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.anniversary,
      this.isActive,
      this.isRejected,
      this.isVerified,
      this.bloodGroup,
      this.organization,
      this.roleId,
      this.mailingAddress,
      this.permanentAddress,
      this.gender,
      this.birthDate,
      this.fatherName,
      this.motherName,
      this.nationality,
      this.passportNumber,
      this.religion,
      this.maritalStatus,
      this.tin,
      this.bankName,
      this.bankAccount,
      this.emergencyName,
      this.emergencyMobileNumber,
      this.emergencyMobileRelationship,
      this.message = 'Your registration process on pending',
      this.userGroup});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        isActive: json['is_active'],
        isRejected: json['is_rejected'],
        isVerified: json['is_verified'],
        roleId: json['role_id'],
        organization: json['organization'],
        bloodGroup: json['blood_group'],
        anniversary: json['anniversary'],
        mailingAddress: json['mailing_address'],
        permanentAddress: json['permanent_address'],
        gender: json['gender'],
        birthDate: json['birth_date'],
        fatherName: json['father_name'],
        motherName: json['mother_name'],
        nationality: json['nationality'],
        passportNumber: json['passport_number'],
        religion: json['religion'],
        maritalStatus: json['marital_status'],
        tin: json['tin'],
        bankName: json['bank_name'],
        bankAccount: json['bank_account'],
        emergencyName: json['emergency_name'],
        emergencyMobileNumber: json['emergency_mobile_number'],
        emergencyMobileRelationship: json['emergency_mobile_relationship'],
        userGroup: json['user_group'],
        message: json['error']);
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'is_active': isActive,
      'is_verified': isVerified,
      'is_rejected': isRejected,
      'role_id': roleId,
      'organization': organization,
      'blood_group': bloodGroup,
      'anniversary': anniversary,
      'mailing_address': mailingAddress,
      'permanent_address': permanentAddress,
      'gender': gender,
      'birth_date': birthDate,
      'father_name': fatherName,
      'nationality': nationality,
      'passport_number': passportNumber,
      'religion': religion,
      'marital_status': maritalStatus,
      'tin': tin,
      'bank_name': bankName,
      'bank_account': bankAccount,
      'emergency_name': emergencyName,
      'emergency_mobile_number': emergencyMobileNumber,
      'emergency_mobile_relationship': emergencyMobileRelationship,
      'user_group': userGroup
      // 'avatar': this.avatar,
    };
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        isActive,
        roleId,
        organization,
        bloodGroup,
        anniversary,
        mailingAddress,
        permanentAddress,
        gender,
        birthDate,
        fatherName,
        nationality,
        passportNumber,
        religion,
        maritalStatus,
        tin,
        bankName,
        bankAccount,
        emergencyName,
        emergencyMobileNumber,
        emergencyMobileRelationship,
        userGroup
      ];
}

class RegistrationData {
  final bool? result;
  final String? error;

  RegistrationData({this.result, this.error});

  factory RegistrationData.fromJson(Map<String, dynamic> json) {
    return RegistrationData(
        result: json['result'],
        error: json['error'] != null ? json['error'] : null);
  }
}

class EventWidgets extends StatelessWidget {
  const EventWidgets(
      {super.key,
      required this.data,
      this.isAppointment = false,
      this.viewAllPressed});

  final MeetingsItem? data;
  final bool? isAppointment;
  final Function()? viewAllPressed;

  @override
  Widget build(BuildContext context) {
    final values = data?.date?.split(' ');
    final month = values?[0];
    final date = values?[1];
    final subStringData = month?.substring(0, 3);
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        )),
        child: Row(children: [
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Colors.blue,
                  ),
                  child: Text(
                    '$subStringData'.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 12.r),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    '$date',
                    style: TextStyle(fontSize: 14.r),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data?.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.r,
                      color: const Color(0xFF222222),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      letterSpacing: 0.5),
                ),
                Visibility(
                  visible: isAppointment!,
                  child: Row(
                    children: [
                      Text(
                        '${data?.time},',
                        style: TextStyle(
                            fontSize: 12.r,
                            color: const Color(0xFF555555),
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: 0.5),
                      ),
                      Expanded(
                        child: Text(
                          ' ${data?.location}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.r,
                              color: const Color(0xFF555555),
                              height: 1.4,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
