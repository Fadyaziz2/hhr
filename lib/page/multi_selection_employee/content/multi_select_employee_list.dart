import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onesthrm/page/select_employee/content/employee_list_shimmer.dart';
import 'package:onesthrm/page/phonebook/phonebook.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class MultiSelectEmployeeList extends StatelessWidget {
  const MultiSelectEmployeeList({super.key});

  @override
  Widget build(BuildContext context) {

    RefreshController refreshController = RefreshController(initialRefresh: false);

    return BlocListener<PhoneBookBloc, PhoneBookState>(
      listenWhen: (oldState, newState) => oldState != newState,
      listener: (context, state) {
        if (state.refreshStatus == PullStatus.loaded) {
          refreshController.refreshCompleted();
        }
      },
      child: BlocBuilder<PhoneBookBloc, PhoneBookState>(
          builder: (context, state) {
              return state.phoneBookUsers?.isNotEmpty == true ? ListView.builder(
                itemCount: state.phoneBookUsers?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  ///enabling multi-selection
                  context.read<PhoneBookBloc>().add(IsMultiSelectionEnabled(true));
                  return InkWell(
                    onTap: () async {
                      context.read<PhoneBookBloc>().add(DoMultiSelectionEvent(state.phoneBookUsers![index]));
                    },
                    onLongPress: (){
                      context.read<PhoneBookBloc>().add(DoMultiSelectionEvent(state.phoneBookUsers![index]));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade300)),
                      ),
                      child: ListTile(
                        title: Text(state.phoneBookUsers?[index].name ?? ""),
                        subtitle: Text(state.phoneBookUsers?[index].designation ?? ""),
                        leading: ClipOval(
                          child: CachedNetworkImage(
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            imageUrl:
                            "${state.phoneBookUsers?[index].avatar}",
                            placeholder: (context, url) => Center(
                              child: Image.asset(
                                  "assets/images/placeholder_image.png"),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                        trailing: Visibility(
                          visible: state.isMultiSelectionEnabled,
                          child: Icon(
                            // state.isMultiSelectionEnabled
                            // selectedItem.contains(allUserProvider
                            //     .responseAllUser!.data!.users![index])
                            //   context.read<PhoneBookBloc>().add(DoMultiSelectionEvent(state.phoneBookUsers![index]));
                            state.selectedItems.contains(state.phoneBookUsers![index])
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            size: 26,
                            color: const Color(0xFF5DB226),
                          ),
                        ),
                        // trailing: InkWell(
                        //   onTap: () {
                        //     /// Dial
                        //     context.read<PhonebookBloc>().add(
                        //         DirectPhoneCall(
                        //             state.phonebookUsers?[index].phone ??
                        //                 ''));
                        //   },
                        //   child: const Padding(
                        //     padding: EdgeInsets.all(8.0),
                        //     child: Icon(
                        //       Icons.phone,
                        //       size: 20,
                        //       color: Colors.grey,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  );
                },
              ) : Shimmer.fromColors(
                baseColor: const Color(0xFFE8E8E8),
                highlightColor: Colors.white,
                child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(
                          100), // radius of 10// green as background color
                    )),
              );
          }),
    );
  }
}
