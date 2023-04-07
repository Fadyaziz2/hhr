import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/enum.dart';
import '../../event/bloc/event_bloc.dart';

part 'pending_event.dart';
part 'pending_state.dart';

class PendingBloc extends Bloc<PendingEvent,PendingState> {

final MetaClubApiClient metaClubApiClient;

PendingBloc({required this.metaClubApiClient}) : super(const PendingState(status: NetworkStatus.initial)){
  on<UserListLoadRequest>(_onUserListRequest);
  on<ApprovalApprovedButton>(_onApprovalButton);
  on<ApprovalRejectButton>(_onApprovalRejectButton);
  on<RejectApprovedButton>(_onRejectApprovedButton);
}

void _onUserListRequest(UserListLoadRequest event,Emitter<PendingState> emit)async{
  emit(const PendingState(status: NetworkStatus.loading));
  try {
    final data = {
      "user_group": "member",
      "type": "all"
    };
    final pendingUserList = await metaClubApiClient.getUserList(data);
    emit(PendingState(status: NetworkStatus.success, userListReponse: pendingUserList));
  } catch (e) {
    emit(const PendingState(status: NetworkStatus.failure));
    throw NetworkRequestFailure(e.toString());
  }
}

void _onApprovalButton(ApprovalApprovedButton event, Emitter<PendingState> emit)async{
  final data = {"user_id" : event.userId,"action": event.action};
  try {
    final events = await metaClubApiClient.postUserApproval(data);
    Fluttertoast.showToast(msg: events['message']);
    add(UserListLoadRequest());
  } catch (e) {
    emit(const PendingState(status: NetworkStatus.failure));
    throw NetworkRequestFailure(e.toString());
  }
}

void _onApprovalRejectButton(ApprovalRejectButton event, Emitter<PendingState> emit)async{
  final data = {"user_id" : event.userId,"action": event.action};
  try {
    final events = await metaClubApiClient.postUserApproval(data);
    Fluttertoast.showToast(msg: events['message']);
    add(UserListLoadRequest());
  } catch (e) {
    emit(const PendingState(status: NetworkStatus.failure));
    throw NetworkRequestFailure(e.toString());
  }
}

void _onRejectApprovedButton(RejectApprovedButton event, Emitter<PendingState> emit)async{
  final data = {"user_id" : event.userId,"action": event.action};
  try {
    final events = await metaClubApiClient.postUserApproval(data);
    Fluttertoast.showToast(msg: events['message']);
    add(UserListLoadRequest());
  } catch (e) {
    emit(const PendingState(status: NetworkStatus.failure));
    throw NetworkRequestFailure(e.toString());
  }
}


}