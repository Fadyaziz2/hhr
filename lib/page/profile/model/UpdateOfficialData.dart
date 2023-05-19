import 'package:dio/dio.dart';

class BodyOfficialInfo {
  int? userId;
  String? name;
  String? email;
  int? departmentId;
  int? designationId;
  String? joiningDate;
  String? employeeType;
  String? employeeId;


  BodyOfficialInfo(
      {int? userId,
        String? name,
        String? email,
        int? departmentId,
        int? designationId,
        int? managerId,
        String? joiningDateDb,
        String? employeeType,
        String? employeeId,
        String? grade}) {
    userId = userId;
    name = name;
    email = email;
    departmentId = departmentId;
    designationId = designationId;
    managerId = managerId;
    joiningDateDb = joiningDateDb;
    employeeType = employeeType;
    employeeId = employeeId;
    grade = grade;
  }


  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = '01903273865';
    map['manager_id'] = '1';
    map['department_id'] = departmentId;
    map['designation_id'] = designationId;
    map['joining_date'] = joiningDate;
    map['employee_type'] = employeeType;
    map['employee_id'] = employeeId;
    return map;
  }

}

class BodyPersonalInfo {

  String? gender;
  String? phone;
  String? birthDate;
  String? address;
  String? nationality;
  String? nidCardNumber;
  String? passportNumber;
  String? facebookLink;
  String? linkedinLink;
  String? instagramLink;
  String? bloodGroup;
  MultipartFile? nidFile;
  MultipartFile? passportFile;


  BodyPersonalInfo({
      this.gender,
      this.phone,
      this.birthDate,
      this.address,
      this.nationality,
      this.nidCardNumber,
      this.passportNumber,
      this.facebookLink,
      this.linkedinLink,
      this.instagramLink,
      this.bloodGroup,
      this.nidFile,
      this.passportFile});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['gender'] = gender;
    map['phone'] = phone;
    map['birth_date'] = birthDate;
    map['address'] = address;
    map['nationality'] = nationality;
    map['nid_card_number'] = nidCardNumber;
    map['passport_number'] = passportNumber;
    map['facebook_link'] = facebookLink;
    map['linkedin_link'] = linkedinLink;
    map['instagram_link'] = instagramLink;
    map['blood_group'] = bloodGroup;
    map['nid_file'] = nidFile;
    map['passport_file'] = passportFile;
    return map;
  }

}