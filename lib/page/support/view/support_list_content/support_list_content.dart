import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onesthrm/page/support/bloc/support_bloc.dart';
import 'package:onesthrm/page/support/bloc/support_event.dart';
import 'package:onesthrm/page/support/bloc/support_state.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SupportListContent extends StatelessWidget {

  const SupportListContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportBloc,SupportState>(builder: (context, state){
      if(state.status == NetworkStatus.loading){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if(state.status == NetworkStatus.success){
       return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
              },
              child: Container(
                color: Colors.grey[100],
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          // context.read<SupportBloc>().add(SelectDatePicker());

                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.angleLeft,
                          size: 30,
                          color: appColor,
                        )),
                    const Spacer(),
                     // Center(
                     //    child: Text(
                     //      "23-07-2023",
                     //      style: const TextStyle(
                     //          fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black),
                     //    )),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          // provider.selectDate(context);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.angleRight,
                          size: 30,
                          color: appColor,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 20,
                children: List<Widget>.generate(
                  supportTicketsButton.length,
                      (int index) {
                    return ChoiceChip(
                      elevation: 3,
                      label: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(supportTicketsButton[index]),
                      ),
                      // selected: provider.value == index,
                      selected: 0 == index,
                      backgroundColor: Colors.white,
                      selectedColor: const Color(0xFF5DB226),
                      labelStyle: TextStyle(
                        color: 0 == index
                            ? Colors.white
                            : const Color(0xFF5DB226),
                      ),
                      onSelected: (bool selected) {
                        // provider.onSelected(selected, index, 1);
                      },
                    );
                  },
                ).toList(),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              itemCount: state.supportListModel?.data?.data?.length ??
                  0,
              itemBuilder: (BuildContext context, int index) {
                var supportList = state.supportListModel?.data?.data?[index];
                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) =>
                    //             SupportTicketDetails(
                    //               supportId: supportList?.id,
                    //             )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          children: [
                            const Positioned.fill(
                              child: Align(
                                  alignment:
                                  Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: colorPrimary,
                                    size: 20,
                                  )),
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  supportList?.subject ?? "",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      supportList?.date ?? "",
                                      style: const TextStyle(
                                          fontSize: 10),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration:
                                      BoxDecoration(
                                        border: Border.all(
                                          color: Color(int
                                              .parse(supportList
                                              ?.typeColor ??
                                              "0xFF000000")),
                                          style: BorderStyle
                                              .solid,
                                          width: 3.0,
                                        ),
                                        color: Color(int
                                            .parse(supportList
                                            ?.typeColor ??
                                            "0xFF000000")),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            8.0),
                                      ),
                                      child: DottedBorder(
                                        color: Colors.white,
                                        borderType:
                                        BorderType.RRect,
                                        radius: const Radius
                                            .circular(5),
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            10,
                                            vertical: 3),
                                        strokeWidth: 1,
                                        child: Text(
                                          supportList
                                              ?.typeName ??
                                              "",
                                          style: const TextStyle(
                                              color: Colors
                                                  .white,
                                              fontSize: 10,
                                              fontWeight:
                                              FontWeight
                                                  .w600),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      decoration:
                                      BoxDecoration(
                                        border: Border.all(
                                          color: Color(int
                                              .parse(supportList
                                              ?.priorityColor ??
                                              "0xFF000000")),
                                          style: BorderStyle
                                              .solid,
                                          width: 3.0,
                                        ),
                                        color: Color(int
                                            .parse(supportList
                                            ?.priorityColor ??
                                            "0xFF000000")),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            8.0),
                                      ),
                                      child: DottedBorder(
                                        color: Colors.white,
                                        borderType:
                                        BorderType.RRect,
                                        radius: const Radius
                                            .circular(5),
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            10,
                                            vertical: 3),
                                        strokeWidth: 1,
                                        child: Text(
                                          supportList
                                              ?.priorityName ??
                                              "",
                                          style: const TextStyle(
                                              color: Colors
                                                  .white,
                                              fontSize: 10,
                                              fontWeight:
                                              FontWeight
                                                  .w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        );
      }
      if (state.status == NetworkStatus.failure){
        return const Center(
          child: Text('Failed to load support list'),
        );
      }
      return const SizedBox();
    });

  }

  showCustomDatePicker({required BuildContext context,required Function(DateTime dateTime) onDatePicked,DateTime? initialDate}) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: SfDateRangePicker(
                  onSelectionChanged: (arg) {
                    onDatePicked(arg.value);
                    Navigator.of(context).pop();
                  },
                  onSubmit: (arg) {},
                  maxDate: DateTime.now().add(const Duration(days: 365)),
                  initialDisplayDate: initialDate ?? DateTime.now(),
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.single,
                  allowViewNavigation: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
