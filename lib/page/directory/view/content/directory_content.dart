import 'package:club_application/page/directory/directory.dart';
import 'package:club_application/page/directory/view/content/directory_item.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import '../../../../res/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectoryContent extends StatelessWidget {

  const DirectoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectoryBloc,DirectoryState>(
      builder: (context,state){
        if(state.status == NetworkStatus.loading){
          return Center(child: CircularProgressIndicator(color: mainColor,));
        }
        if(state.status == NetworkStatus.success) {
          if(state.directories != null) {
            return ListView.builder(
              itemCount: state.directories!.directories.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {

                final directory = state.directories!.directories.elementAt(index);

                return DirectoryItem(directory: directory,);
              },
            );
          }
        }
        if (state.status == NetworkStatus.failure) {
          return const Center(
            child: Text('Error to load'),
          );
        }
        return const SizedBox();
      },
    );
  }
}
