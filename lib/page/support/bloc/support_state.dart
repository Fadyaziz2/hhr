import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class SupportState extends Equatable {
  final NetworkStatus? status;
  final SupportListModel? supportListModel;

  const SupportState({this.status,this.supportListModel});

  SupportState copy({NetworkStatus? status,SupportListModel? supportListModel}) {
    return SupportState(status: this.status,supportListModel: this.supportListModel);
  }

  @override
  List<Object?> get props => [status,supportListModel];
}
