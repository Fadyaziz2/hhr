part of 'attendance_method_bloc.dart';


abstract class AttendanceMethodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceNavEvent extends AttendanceMethodEvent {
  final BuildContext context;
  final String? slugName;
  AttendanceNavEvent({
    this.slugName,
    required this.context,
  });
  @override
  List<Object?> get props => [
        slugName,
        context,
      ];
}
