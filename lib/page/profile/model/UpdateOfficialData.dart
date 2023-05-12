
class BodyOfficialInfo {
  int? userId;
  String? name;
  String? email;
  int? departmentId;
  int? designationId;
  String? joiningDateDb;
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
    map['user_id'] = userId;
    map['name'] = name;
    map['email'] = email;
    map['department_id'] = departmentId;
    map['designation_id'] = designationId;
    map['joining_date'] = joiningDateDb;
    map['employee_type'] = employeeType;
    map['employee_id'] = employeeId;
    return map;
  }

}