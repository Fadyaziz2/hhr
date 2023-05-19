part of 'update_profile_bloc.dart';


class UpdateProfileState extends Equatable {
  final NetworkStatus status;
  final Department? department;
  const UpdateProfileState({this.status = NetworkStatus.initial,this.department});

  UpdateProfileState copyWith({Map<String,dynamic>? map, NetworkStatus? status,Department? department}) {
    return UpdateProfileState(status: status ?? this.status,department: department ?? this.department);
  }

  @override
  List<Object?> get props => [status,department];
}
