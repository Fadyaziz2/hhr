import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../authentication/bloc/authentication_bloc.dart';
import '../../bloc/profile_bloc.dart';

class EditProfileInfo extends StatelessWidget {
  final String? pageName;

  const EditProfileInfo({Key? key, required this.pageName}) : super(key: key);

  static Route route({required String pageName}) =>
      MaterialPageRoute(builder: (_) => EditProfileInfo(pageName: pageName));

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
              const Text(
                'Name',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
               TextField(
                style: const TextStyle(fontSize: 14),
                keyboardType: TextInputType.name,
                controller: TextEditingController(text: '${user?.user?.name}'),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                  hintText: 'Enter Name',
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
                'email*',
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                  hintText: 'Enter Email',
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
                'Department',
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'Select Department',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Designation',
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'Select Department',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'manager*',
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'Select Manager',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                height: 20,
              ),
              const Text(
                'Employee Type',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, spreadRadius: 1),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text(
                      'Enter Employee Type',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: 'Permanent',
                    icon: const Icon(
                      Icons.arrow_downward,
                      size: 20,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String? newValue) {},
                    items: ['Permanent', 'Contact']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
