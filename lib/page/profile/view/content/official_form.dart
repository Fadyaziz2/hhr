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

class OfficialForm extends StatefulWidget {
  final Profile? profile;
  final Bloc bloc;
  final Settings? settings;
  final Function(BodyOfficialInfo) onOfficialUpdate;

  const OfficialForm({Key? key,
    required this.profile,
    required this.bloc,
    required this.onOfficialUpdate,
    required this.settings})
      : super(key: key);

  @override
  State<OfficialForm> createState() => _OfficialFormState();
}

class _OfficialFormState extends State<OfficialForm> {
  BodyOfficialInfo official = BodyOfficialInfo();

  @override
  void initState() {
    official.name = widget.profile?.official?.name;
    official.email = widget.profile?.official?.email;
    official.departmentId = widget.profile?.official?.departmentId;
    official.designationId = widget.profile?.official?.designationId;
    official.joiningDate = widget.profile?.official?.joiningDate;
    official.employeeType = widget.profile?.official?.employeeType;
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
            official.name = data;
            widget.onOfficialUpdate(official);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'email*',
          value: '${widget.profile?.official?.email}',
          onData: (data) {
            official.email = data;
            widget.onOfficialUpdate(official);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        BlocBuilder<UpdateProfileBloc,UpdateProfileState>(
          builder: (context,state){
            return ProfileDropDown(
              items: widget.settings?.data?.departments ?? [],
              title: 'Department',
              item: widget.bloc.state.department ??
                  Department(
                      id: widget.profile?.official?.departmentId,
                      title: widget.profile?.official?.department),
              onChange: (department) {
                official.departmentId = department?.id;
                widget.onOfficialUpdate(official);
                widget.bloc.add(OnDepartmentUpdate(department: department));
              },
            );
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
          label: getDateddMMMyyyyString(dateTime: widget.bloc.state.dateTime) ?? official.joiningDate ?? 'Select Joining Date',
          onDatePicked: (DateTime date) {

            official.joiningDate = getDateAsString(dateTime: date, format: 'yyyy-MM-dd');
            widget.onOfficialUpdate(official);
            widget.bloc.add(OnJoiningDateUpdate(date: date));
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        const Text(
          'Employee Id',
          style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
         TextField(
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.emailAddress,
          onChanged: (data) {
            official.employeeId = data;
            widget.onOfficialUpdate(official);
          },
          decoration: const InputDecoration(
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
            widget.bloc.add(ProfileUpdate(slug: 'official', data: official.toJson()));
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
