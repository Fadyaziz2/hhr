import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/view/content/profile_dropdown.dart';
import '../../../../res/date_utils.dart';
import '../../../../res/enum.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../../../res/widgets/date_picker_widget.dart';
import '../../bloc/update/update_profile_bloc.dart';
import '../../model/UpdateOfficialData.dart';
import 'custom_text_field_with_title.dart';

class PersonalForm extends StatefulWidget {
  final Profile? profile;
  final Bloc bloc;
  final Settings? settings;
  final Function(BodyPersonalInfo) onPersonalUpdate;

  const PersonalForm({Key? key,
    required this.profile,
    required this.bloc,
    required this.onPersonalUpdate,
    required this.settings})
      : super(key: key);

  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {

  BodyPersonalInfo personal = BodyPersonalInfo();

  @override
  void initState() {

    personal.gender = widget.profile?.personal?.gender ?? 'male';
    personal.phone = widget.profile?.personal?.phone;
    personal.birthDate = widget.profile?.personal?.birthDate;
    personal.address = widget.profile?.personal?.address;
    personal.nationality = widget.profile?.personal?.nationality;
    personal.nidCardNumber = widget.profile?.personal?.nid;
    personal.nidFile = null;
    personal.passportNumber = widget.profile?.personal?.passport;
    personal.passportFile = null;
    personal.bloodGroup = widget.profile?.personal?.bloodGroup;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    personal.gender ??= widget.bloc.state.gender;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "gender*",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<String>(
                      value: "male",
                      groupValue:  personal.gender,
                      onChanged: (String? genderValue) {
                        if (kDebugMode) {
                          print("Radio $genderValue");
                        }
                        personal.gender = genderValue;
                        widget.onPersonalUpdate(personal);
                        widget.bloc.add(OnGenderUpdate(gender: personal.gender!));
                      }),
                  const Text(
                    "male",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<String>(
                      value: "female",
                      groupValue:  personal.gender,
                      onChanged: (String? genderValue) {
                        if (kDebugMode) {
                          print("Radio $genderValue");
                        }
                        personal.gender = genderValue;
                        widget.onPersonalUpdate(personal);
                        widget.bloc.add(OnGenderUpdate(gender: personal.gender!));
                      }),
                  const Text(
                    "female",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<String>(
                      value: "unisex",
                      groupValue:  personal.gender,
                      onChanged: (String? genderValue) {
                        if (kDebugMode) {
                          print("Radio $genderValue");
                        }
                        personal.gender = genderValue;
                        widget.onPersonalUpdate(personal);
                        widget.bloc.add(OnGenderUpdate(gender: personal.gender!));
                      }),
                  const Text(
                    "other",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'phone',
          value: '${widget.profile?.personal?.phone}',
          onData: (data) {
            personal.phone = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        const Text(
          'Date Of Birth',
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        CustomDatePicker(
          label: getDateddMMMyyyyString(dateTime: widget.bloc.state.dateTime) ?? personal.birthDate ?? 'Select Birth Date',
          onDatePicked: (DateTime date) {
            personal.birthDate = getDateAsString(dateTime: date, format: 'yyyy-MM-dd');
            widget.onPersonalUpdate(personal);
            widget.bloc.add(OnJoiningDateUpdate(date: date));
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'Address',
          value: widget.profile?.personal?.address ?? '',
          onData: (data) {
            personal.phone = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'Nationality',
          value: widget.profile?.personal?.address ?? '',
          onData: (data) {
            personal.phone = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'NID',
          value: widget.profile?.personal?.nid ?? '',
          onData: (data) {
            personal.phone = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'Passport Number',
          value: widget.profile?.personal?.nid ?? '',
          onData: (data) {
            personal.phone = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        const SimpleDropDown(
          items: ['A+','A-','B+','B+'],
          title: 'Blood'
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomButton1(
          onTap: () {
            widget.bloc.add(ProfileUpdate(slug: 'personal', data: personal.toJson()));
          },
          text: 'save',
          radius: 8.0,
          asyncCall: widget.bloc.state.status == NetworkStatus.loading,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
