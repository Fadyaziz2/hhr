part of 'report_bloc.dart';

class ReportState extends Equatable {
  final NetworkStatus? status;

  const ReportState({this.status});

  ReportState copyWith({NetworkStatus? status}) {
    return ReportState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
