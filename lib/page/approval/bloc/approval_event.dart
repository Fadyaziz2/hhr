part of 'approval_bloc.dart';

abstract class ApprovalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApprovalInitialDataRequest extends ApprovalEvent {
  ApprovalInitialDataRequest();

  @override
  List<Object?> get props => [];
}
