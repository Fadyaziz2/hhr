import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/view/content/persoonal_form.dart';
import 'package:onesthrm/page/profile/view/content/profile_dropdown.dart';
import 'package:onesthrm/res/enum.dart';
import '../../../../res/date_utils.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../../../res/widgets/date_picker_widget.dart';
import '../../bloc/update/update_profile_bloc.dart';
import '../../model/UpdateOfficialData.dart';
import 'custom_text_field_with_title.dart';
import 'official_form.dart';

class EditProfileContent extends StatefulWidget {
  final String? pageName;
  final Settings? settings;
  final Profile? profile;
  final Bloc bloc;

  const EditProfileContent(
      {Key? key,
      required this.pageName,
      required this.settings,
      required this.profile,
      required this.bloc})
      : super(key: key);

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {

  BodyOfficialInfo official = BodyOfficialInfo();
  BodyPersonalInfo personal = BodyPersonalInfo();

  @override
  Widget build(BuildContext context) {

    UpdateProfileBloc  bloc = context.watch<UpdateProfileBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(widget.pageName == 'official')
              OfficialForm(profile: widget.profile, bloc: bloc, onOfficialUpdate: (data) {
                official = data;
                print(official.toJson());
              }, settings: widget.settings,),
            if(widget.pageName == 'personal')
              PersonalForm(profile: widget.profile, bloc: bloc, onOfficialUpdate: (data) {
                personal = data;
                print(personal.toJson());
              }, settings: widget.settings,),
          ],
        ),
      ),
    );
  }
}
