part of 'pending_bloc.dart';

abstract class PendingEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class UserListLoadRequest extends PendingEvent{}

class ApprovalApprovedButton extends PendingEvent{
  final int? userId;
  final String action;

  ApprovalApprovedButton({required this.userId,required this.action});

  @override
  List<Object?> get props => [userId,action];

}

class ApprovalRejectButton extends PendingEvent{
  final int? userId;
  final String action;

  ApprovalRejectButton({required this.userId,required this.action});

  @override
  List<Object?> get props => [userId,action];

}

class RejectApprovedButton extends PendingEvent{
  final int? userId;
  final String action;

  RejectApprovedButton({required this.userId,required this.action});

  @override
  List<Object?> get props => [userId,action];

}


