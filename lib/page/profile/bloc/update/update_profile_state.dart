part of 'update_profile_bloc.dart';

class UpdateProfileState extends Equatable {
  final NetworkStatus status;
  final Department? department;
  final DateTime? dateTime;

  const UpdateProfileState(
      {this.status = NetworkStatus.initial, this.department, this.dateTime});

  UpdateProfileState copyWith(
      {Map<String, dynamic>? map,
      NetworkStatus? status,
      Department? department,
      DateTime? dateTime}) {
    return UpdateProfileState(
        status: status ?? this.status,
        department: department ?? this.department,
        dateTime: dateTime ?? this.dateTime);
  }

  @override
  List<Object?> get props => [status, department, dateTime];
}
