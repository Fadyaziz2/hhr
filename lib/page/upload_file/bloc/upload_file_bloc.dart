import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/upload_file/bloc/bloc.dart';
import '../../../res/dialogs/custom_dialogs.dart';

class UploadFileBloc extends Bloc<UploadFileEvent,UploadFileState>{

  final MetaClubApiClient metaClubApiClient;

  UploadFileBloc({required this.metaClubApiClient}) : super(const UploadFileState()){
    on<SelectFile>(_onSelectFile);
    on<UploadFile>(_onUploadFile);
  }

  _onSelectFile(SelectFile event,Emitter<UploadFileState> emit) async {

    File? file = await pickFile(event.context);
    print('filee ${file?.path}');
  }

  _onUploadFile(UploadFile event,Emitter<UploadFileState> emit){

  }

}