import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:equatable/equatable.dart';
import '../../../res/enum.dart';

part 'directory_event.dart';
part 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent,DirectoryState>{

  final MetaClubApiClient metaClubApiClient;

  DirectoryBloc({required this.metaClubApiClient}):super(const DirectoryState(status: NetworkStatus.initial)){
    on<DirectoryLoadRequest>(_onDirectoryLoadRequest);
  }
  void _onDirectoryLoadRequest(DirectoryLoadRequest event,Emitter<DirectoryState> emit) async {
    emit(const DirectoryState(status: NetworkStatus.loading));
    try{
      final directories = await metaClubApiClient.directories();
      emit(DirectoryState(status: NetworkStatus.success,directories: directories));
    }catch(_){
      emit(const DirectoryState(status: NetworkStatus.failure));
      throw ContactRequestFailure();
    }
  }
}
