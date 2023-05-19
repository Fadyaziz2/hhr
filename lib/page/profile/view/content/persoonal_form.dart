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
  final Function(BodyPersonalInfo) onOfficialUpdate;

  const PersonalForm({Key? key,
    required this.profile,
    required this.bloc,
    required this.onOfficialUpdate,
    required this.settings})
      : super(key: key);

  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  BodyPersonalInfo personal = BodyPersonalInfo();

  @override
  void initState() {
    personal.gender = widget.profile?.official?.name;
    personal.phone = widget.profile?.official?.email;
    personal.birthDate = widget.profile?.official?.email;
    personal.address = widget.profile?.official?.email;
    personal.nationality = widget.profile?.official?.joiningDate;
    personal.nidCardNumber = widget.profile?.official?.employeeType;
    personal.nidFile = null;
    personal.passportNumber = widget.profile?.official?.employeeType;
    personal.passportFile = null;
    personal.bloodGroup = widget.profile?.official?.employeeType;
    personal.linkedinLink = widget.profile?.official?.employeeType;
    personal.facebookLink = widget.profile?.official?.employeeType;
    personal.instagramLink = widget.profile?.official?.employeeType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          title: 'Name',
          value: '${widget.profile?.official?.name}',
          onData: (data) {
            personal.name = data;
            widget.onOfficialUpdate(personal);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'email*',
          value: '${widget.profile?.official?.email}',
          onData: (data) {
            personal.email = data;
            widget.onOfficialUpdate(personal);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        ProfileDropDown(
          items: widget.settings?.data?.departments ?? [],
          title: 'Department',
          item: widget.bloc.state.department ??
              Department(
                  id: widget.profile?.official?.departmentId,
                  title: widget.profile?.official?.department),
          onChange: (department) {
            personal.departmentId = department?.id;
            widget.onOfficialUpdate(personal);
            widget.bloc.add(OnDepartmentUpdate(department: department));
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        const Text(
          'Date Of Joining',
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDatePicker(
          label: getDateddMMMyyyyString(dateTime: widget.bloc.state.dateTime) ?? personal.joiningDate ?? 'Select Joining Date',
          onDatePicked: (DateTime date) {

            personal.joiningDate = getDateAsString(dateTime: date, format: 'yyyy-MM-dd');
            widget.onOfficialUpdate(personal);
            widget.bloc.add(OnJoiningDateUpdate(date: date));
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        const Text(
          'Employee Id',
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const TextField(
          style: TextStyle(fontSize: 14),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            fillColor: Colors.red,
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            hintText: 'Enter Employee Id',
            hintStyle: TextStyle(fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton1(
          onTap: () {
            widget.bloc.add(ProfileUpdate(
                slug: 'official', data: personal.toJson()));
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
