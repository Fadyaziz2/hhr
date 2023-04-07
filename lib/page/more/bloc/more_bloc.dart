import 'package:equatable/equatable.dart';
import '../../../res/enum.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/src/models/more.dart';
part 'more_event.dart';
part 'more_state.dart';


class MoreBloc extends Bloc<MoreEvent,MoreState>{

  final MetaClubApiClient metaClubApiClient;

  MoreBloc({required this.metaClubApiClient}):super(const MoreState(status: NetworkStatus.initial)){
    on<ContentLoadRequest>(_onMoreContentRequest);
  }

  void _onMoreContentRequest(ContentLoadRequest event,Emitter<MoreState> emit) async {

    emit(const MoreState(status: NetworkStatus.loading));

    try{
      final mores = await metaClubApiClient.mores();
      emit(MoreState(mores: mores,status: NetworkStatus.success));
    }catch(_){
      emit(const MoreState(status: NetworkStatus.failure));
      throw ContactRequestFailure();
    }
  }
}
