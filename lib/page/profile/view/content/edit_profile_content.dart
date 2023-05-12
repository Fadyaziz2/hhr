import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/view/content/profile_dropdown.dart';

import '../../bloc/update/update_profile_bloc.dart';
import '../../model/UpdateOfficialData.dart';
import 'custom_text_field_with_title.dart';

class EditProfileContent extends StatefulWidget {
  final String? pageName;
  final Settings? settings;
  final Profile? profile;
  final VoidCallback onSave;

  const EditProfileContent(
      {Key? key,
      required this.pageName,
      required this.settings,
      required this.profile,
      required this.onSave})
      : super(key: key);

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {

  BodyOfficialInfo official = BodyOfficialInfo();

  @override
  void initState() {
    super.initState();
    official.name = widget.profile?.official?.name;
    official.email = widget.profile?.official?.email;
    official.departmentId = widget.profile?.official?.departmentId;
    official.designationId = widget.profile?.official?.designationId;
    official.joiningDateDb = widget.profile?.official?.joiningDate;
    official.employeeType = widget.profile?.official?.employeeType;
  }

  @override
  Widget build(BuildContext context) {

     Bloc  bloc = context.watch<UpdateProfileBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              title: 'Name',
              value: '${widget.profile?.official?.name}',
              onData: (data) {
                official.name = data;
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
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            ProfileDropDown(
              items: widget.settings?.data?.departments ?? [],
              title: 'Department',
              item: context.watch<UpdateProfileBloc>().state.department,
              onChange: (department) {
                official.departmentId = department?.id;
                bloc.add(OnDepartmentUpdate(department: department));
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            ProfileDropDown(
                items: widget.settings?.data?.designations ?? [],
                title: 'Designation',
                item: widget.settings?.data?.designations.first,
                onChange: (department) {
                  official.designationId = department?.id;
                }),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'Date Of Joining',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Select joining Date',
                      style: TextStyle(fontSize: 14),
                    ),
                    Icon(Icons.date_range_outlined)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SimpleDropDown(
              items: widget.settings?.data?.employeeTypes ?? [],
              title: 'Employee Type',
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'Employee Id',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              style: TextStyle(fontSize: 14),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                fillColor: Colors.red,
                contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
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
            const Text(
              'Grade',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  bloc.add(ProfileUpdate(
                      slug: 'personal', data: official.toJson()));
                  widget.onSave.call();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text('save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
