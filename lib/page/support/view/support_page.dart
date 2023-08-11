import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onesthrm/res/const.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrimary,
        onPressed: () {
          // NavUtil.replaceScreen(context, const CreateSupportTicket());
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF00CCFF),
                  colorPrimary,
                ],
                begin: FractionalOffset(3.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: Text(
          tr("all_support_tickets"),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: appBarColor),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              // provider.selectDate(context);
            },
            child: Container(
              color: Colors.grey[100],
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // provider.selectDate(context);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.angleLeft,
                        size: 30,
                        color: appColor,
                      )),
                  const Spacer(),
                  const Center(
                      child: Text(
                        // provider.monthYear ?? "",
                        "23-07-2023",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
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
          // provider.isLoading == true
          //     ? provider
          //     .responseSupportTicketList!.data!.data!.isNotEmpty
          //     ? Expanded(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: provider.responseSupportTicketList
          //         ?.data?.data?.length ??
          //         0,
          //     itemBuilder: (BuildContext context, int index) {
          //       var supportList = provider
          //           .responseSupportTicketList
          //           ?.data
          //           ?.data?[index];
          //       return InkWell(
          //         onTap: () {
          //           // Navigator.push(
          //           //     context,
          //           //     MaterialPageRoute(
          //           //         builder: (_) =>
          //           //             SupportTicketDetails(
          //           //               supportId: supportList?.id,
          //           //             )));
          //         },
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 12.0, vertical: 5),
          //           child: Card(
          //             elevation: 4,
          //             child: Padding(
          //               padding: const EdgeInsets.all(16.0),
          //               child: Stack(
          //                 children: [
          //                   const Positioned.fill(
          //                     child: Align(
          //                         alignment:
          //                         Alignment.centerRight,
          //                         child: Icon(
          //                           Icons.arrow_forward_ios,
          //                           color: colorPrimary,
          //                           size: 20,
          //                         )),
          //                   ),
          //                   Column(
          //                     crossAxisAlignment:
          //                     CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         supportList?.subject ?? "",
          //                         style: const TextStyle(
          //                             fontSize: 12,
          //                             color: Colors.black,
          //                             fontWeight:
          //                             FontWeight.w600),
          //                       ),
          //                       Row(
          //                         children: [
          //                           Text(
          //                             supportList?.date ?? "",
          //                             style: const TextStyle(
          //                                 fontSize: 10),
          //                           ),
          //                           const SizedBox(
          //                             width: 10,
          //                           ),
          //                           Container(
          //                             decoration:
          //                             BoxDecoration(
          //                               border: Border.all(
          //                                 color: Color(int
          //                                     .parse(supportList
          //                                     ?.typeColor ??
          //                                     "0xFF000000")),
          //                                 style: BorderStyle
          //                                     .solid,
          //                                 width: 3.0,
          //                               ),
          //                               color: Color(int
          //                                   .parse(supportList
          //                                   ?.typeColor ??
          //                                   "0xFF000000")),
          //                               borderRadius:
          //                               BorderRadius
          //                                   .circular(
          //                                   8.0),
          //                             ),
          //                             child: DottedBorder(
          //                               color: Colors.white,
          //                               borderType:
          //                               BorderType.RRect,
          //                               radius: const Radius
          //                                   .circular(5),
          //                               padding:
          //                               const EdgeInsets
          //                                   .symmetric(
          //                                   horizontal:
          //                                   10,
          //                                   vertical: 3),
          //                               strokeWidth: 1,
          //                               child: Text(
          //                                 supportList
          //                                     ?.typeName ??
          //                                     "",
          //                                 style: const TextStyle(
          //                                     color: Colors
          //                                         .white,
          //                                     fontSize: 10,
          //                                     fontWeight:
          //                                     FontWeight
          //                                         .w600),
          //                               ),
          //                             ),
          //                           ),
          //                           const SizedBox(
          //                             width: 8,
          //                           ),
          //                           Container(
          //                             decoration:
          //                             BoxDecoration(
          //                               border: Border.all(
          //                                 color: Color(int
          //                                     .parse(supportList
          //                                     ?.priorityColor ??
          //                                     "0xFF000000")),
          //                                 style: BorderStyle
          //                                     .solid,
          //                                 width: 3.0,
          //                               ),
          //                               color: Color(int
          //                                   .parse(supportList
          //                                   ?.priorityColor ??
          //                                   "0xFF000000")),
          //                               borderRadius:
          //                               BorderRadius
          //                                   .circular(
          //                                   8.0),
          //                             ),
          //                             child: DottedBorder(
          //                               color: Colors.white,
          //                               borderType:
          //                               BorderType.RRect,
          //                               radius: const Radius
          //                                   .circular(5),
          //                               padding:
          //                               const EdgeInsets
          //                                   .symmetric(
          //                                   horizontal:
          //                                   10,
          //                                   vertical: 3),
          //                               strokeWidth: 1,
          //                               child: Text(
          //                                 supportList
          //                                     ?.priorityName ??
          //                                     "",
          //                                 style: const TextStyle(
          //                                     color: Colors
          //                                         .white,
          //                                     fontSize: 10,
          //                                     fontWeight:
          //                                     FontWeight
          //                                         .w600),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // )
          //     : Expanded(
          //   child: Center(
          //       child: Text(
          //         tr("no_support_tickets_found"),
          //         style: const TextStyle(
          //             color: Color(0x65555555),
          //             fontSize: 22,
          //             fontWeight: FontWeight.w500),
          //       )),
          // )
          //     : const SizedBox()
        ],
      ),
    );
  }
}
