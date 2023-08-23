import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class SupportState extends Equatable {
  final NetworkStatus? status;
  final SupportListModel? supportListModel;
  final Filter filter;

  const SupportState({this.status,this.supportListModel, this.filter = Filter.open});

  SupportState copy({NetworkStatus? status,SupportListModel? supportListModel, Filter? filter}) {
    return SupportState(status: status ?? this.status,supportListModel: supportListModel ?? this.supportListModel, filter: filter ?? this.filter);
  }

  @override
  List<Object?> get props => [status,supportListModel,filter];
}
