import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class HistoryItem extends StatelessWidget {
  final History? myHistoryList;

  const HistoryItem({super.key, this.myHistoryList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blueAccent,
                          size: 20,
                        )),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            myHistoryList?.month ?? "",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.blue),
                          ),
                          Text(
                            myHistoryList?.day ?? "",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myHistoryList?.title ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${myHistoryList?.started ?? ""} - ${myHistoryList?.reached ?? ""}",
                                  style: const TextStyle(fontSize: 10),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(int.parse(
                                      myHistoryList?.statusColor ??
                                          "0xFF1FB89E")),
                                  style: BorderStyle.solid,
                                  width: 3.0,
                                ),
                                color: Color(int.parse(
                                    myHistoryList?.statusColor ??
                                        "0xFF1FB89E")),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DottedBorder(
                                color: Colors.white,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                strokeWidth: 1,
                                child: Text(
                                  myHistoryList?.status ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
