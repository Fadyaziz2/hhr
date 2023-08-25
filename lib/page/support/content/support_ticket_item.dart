import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../res/const.dart';

class SupportTicketItem extends StatelessWidget {

  final SupportModel supportModel;

  const SupportTicketItem({super.key,required this.supportModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
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
                      supportModel.subject ?? "",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight:
                          FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          supportModel.date ?? "",
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
                                  .parse(supportModel.typeColor ?? "0xFF000000")),
                              style: BorderStyle
                                  .solid,
                              width: 3.0,
                            ),
                            color: Color(int.parse(supportModel.typeColor ?? "0xFF000000")),
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
                              supportModel.typeName ?? "",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10, fontWeight: FontWeight.w600),
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
                                  .parse(supportModel.priorityColor ?? "0xFF000000")),
                              style: BorderStyle
                                  .solid,
                              width: 3.0,
                            ),
                            color: Color(int.parse(supportModel.priorityColor ?? "0xFF000000")),
                            borderRadius: BorderRadius.circular(8.0),
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
                              supportModel.priorityName ?? "",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
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
  }
}
