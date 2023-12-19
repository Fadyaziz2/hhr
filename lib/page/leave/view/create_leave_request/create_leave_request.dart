import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_bloc.dart';
import 'package:onesthrm/page/profile/view/content/custom_text_field_with_title.dart';
import 'package:onesthrm/page/select_employee/view/select_employee.dart';
import 'package:onesthrm/page/upload_file/view/upload_doc_content.dart';
import 'package:onesthrm/res/enum.dart';
import '../../../../res/widgets/custom_button.dart';

class CreateLeaveRequest extends StatelessWidget {
  final String? starDate;
  final String? endDate;
  final int? leaveTypeId;

  const CreateLeaveRequest(
      {super.key, this.starDate, this.leaveTypeId, this.endDate});

  @override
  Widget build(BuildContext context) {
    BodyCreateLeaveModel bodyCreateLeave = BodyCreateLeaveModel();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr("request_leave")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                    title: "note".tr(),
                    hints: "write_reason".tr(),
                    errorMsg: "response_can't_be_empty".tr(),
                    maxLine: 7,
                    onData: (data) {
                      bodyCreateLeave.reason = data;
                    }),
                const SizedBox(
                  height: 16,
                ),
                UploadDocContent(
                  onFileUpload: (FileUpload? data) {
                    if (kDebugMode) {
                      print(data?.fileId);
                    }
                    bodyCreateLeave.imageUrl = data?.previewUrl;
                  },
                  initialAvatar:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                ),
                const SizedBox(
                  height: 25,
                ),
                BlocBuilder<LeaveBloc, LeaveState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("substitute"),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Card(
                          child: ListTile(
                            onTap: () async {
                              PhoneBookUser employee = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectEmployeePage(),
                                  ));
                              // ignore: use_build_context_synchronously
                              context
                                  .read<LeaveBloc>()
                                  // ignore: use_build_context_synchronously
                                  .add(SelectEmployee(employee));
                            },
                            title: Text(state.selectedEmployee?.name! ??
                                tr("add_a_Substitute")),
                            subtitle: Text(
                                state.selectedEmployee?.designation! ??
                                    tr("add_a_Designation")),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(state
                                      .selectedEmployee?.avatar ??
                                  'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                            ),
                            trailing: const Icon(Icons.edit),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomButton(
                          title: "next".tr(),
                          padding: 0,
                          isLoading: state.status == NetworkStatus.loading,
                          clickButton: () {
                            if (formKey.currentState!.validate() &&
                                state.status != NetworkStatus.loading) {
                              final user =
                                  context.read<AuthenticationBloc>().state.data;
                              bodyCreateLeave.userId = user?.user?.id;
                              bodyCreateLeave.assignLeaveId = leaveTypeId;
                              bodyCreateLeave.substituteId =
                                  state.selectedEmployee?.id;
                              bodyCreateLeave.applyDate = starDate;
                              bodyCreateLeave.leaveTo = endDate;
                              bodyCreateLeave.leaveFrom = starDate;
                              context.read<LeaveBloc>().add(SubmitLeaveRequest(
                                  bodyCreateLeaveModel: bodyCreateLeave,
                                  uid: user!.user!.id!,
                                  context: context));
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
