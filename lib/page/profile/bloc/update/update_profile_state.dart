part of 'update_profile_bloc.dart';

class UpdateProfileState extends Equatable {
  final NetworkStatus status;
  final Department? department;
  final DateTime? dateTime;
  final String? gender;

  const UpdateProfileState(
      {this.status = NetworkStatus.initial, this.department, this.dateTime,this.gender});

  UpdateProfileState copyWith(
      {Map<String, dynamic>? map,
      NetworkStatus? status,
      Department? department,
      String? gender,
      DateTime? dateTime}) {
    return UpdateProfileState(
        status: status ?? this.status,
        department: department ?? this.department,
        gender: gender ?? this.gender,
        dateTime: dateTime ?? this.dateTime);
  }

  @override
  List<Object?> get props => [status, department, dateTime,gender];
}
