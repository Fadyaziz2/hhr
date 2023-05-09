import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/view/content/profile_dropdown.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import 'custom_text_field_with_title.dart';

class EditProfileInfo extends StatelessWidget {
  final String? pageName;
  final Settings? settings;

  const EditProfileInfo({Key? key, required this.pageName,required this.settings}) : super(key: key);

  static Route route({required String pageName,required Settings? settings}) =>
      MaterialPageRoute(builder: (_) => EditProfileInfo(pageName: pageName,settings: settings,));

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Update $pageName data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                title: 'Name',
                value: '${user?.user?.name}',
                onData: (data) {

                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomTextField(
                title: 'email*',
                value: '${user?.user?.email}',
                onData: (data) {

                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              ProfileDropDown(items: settings?.data?.departments ?? [],title: 'Department',),
              const SizedBox(
                height: 16.0,
              ),
              ProfileDropDown(items: settings?.data?.designations ?? [],title: 'Designation'),
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
              SimpleDropDown(items: settings?.data?.employeeTypes ?? [],title: 'Employee Type',),
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
                height: 10,
              ),
              const TextField(
                style: TextStyle(fontSize: 14),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.red,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                  hintText: 'Enter Grade',
                  hintStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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
      ),
    );
  }
}
