import 'package:equatable/equatable.dart';

class LoginData {
  final String? token;
  final User? user;

  LoginData({this.token, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(token: json['token'], user: User.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'data': user?.toJson()};
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
  final String? birth_date;
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
      this.birth_date,
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
        birth_date: json['birth_date'],
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
        message: json['error']
        );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'is_active': this.isActive,
      'is_verified': this.isVerified,
      'is_rejected': this.isRejected,
      'role_id': this.roleId,
      'organization': this.organization,
      'blood_group': this.bloodGroup,
      'anniversary': this.anniversary,
      'mailing_address': this.mailingAddress,
      'permanent_address': this.permanentAddress,
      'gender': this.gender,
      'birth_date': this.birth_date,
      'father_name': this.fatherName,
      'nationality': this.nationality,
      'passport_number': this.passportNumber,
      'religion': this.religion,
      'marital_status': this.maritalStatus,
      'tin': this.tin,
      'bank_name': this.bankName,
      'bank_account': this.bankAccount,
      'emergency_name': this.emergencyName,
      'emergency_mobile_number': this.emergencyMobileNumber,
      'emergency_mobile_relationship': this.emergencyMobileRelationship,
      'user_group': this.userGroup
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
        birth_date,
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

  factory RegistrationData.fromJson(Map<String,dynamic> json){
    return RegistrationData(result: json['result'],error: json['error'] != null ? json['error'] : null);
  }

}
