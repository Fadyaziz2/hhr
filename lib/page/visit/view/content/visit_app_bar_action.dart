import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../../../../res/const.dart';
import '../../bloc/visit_bloc.dart';
import '../update_visit/update_visit.dart';

class VisitAppBarAction extends StatelessWidget {
  final int visitID;
  const VisitAppBarAction({super.key,required this.visitID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        NavUtil.navigateScreen(
            context,
            BlocProvider.value(
                value: context.read<VisitBloc>(),
                child:  UpdateVisit(visitID: visitID,)));
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 12,
          backgroundColor: Colors.white,
          child: ClipOval(
              child: Icon(
            Icons.edit,
            size: 20,
            color: colorPrimary,
          )),
        ),
      ),
    );
  }
}
