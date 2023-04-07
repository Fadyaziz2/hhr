import 'dart:ui';
import 'package:club_application/page/election/bloc/election_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../res/const.dart';
import '../../../../res/enum.dart';

class ElectionContent extends StatefulWidget {
  const ElectionContent({Key? key}) : super(key: key);

  @override
  State<ElectionContent> createState() => _ElectionContentState();
}

class _ElectionContentState extends State<ElectionContent> {
  ///if radio button used
  // List<List<int>> selectedPresidentList =  List.filled(3, List.filled(3, -1));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectionBloc, ElectionState>(builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return Center(
            child: CircularProgressIndicator(
          color: mainColor,
        ));
      }
      if (state.status == NetworkStatus.success) {
        if (state.electionInfo != null) {
          return ListView.builder(
            itemCount: state.electionInfo!.elections!.length,
            itemBuilder: (BuildContext context, int index) {
              final electionsData = state.electionInfo!.elections![index];
              // final bool voteDone =  electionsData.candidate!.any((element) => element.isVote! == true);

              return electionsData.isVotted == false
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Ink(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title:
                                    Text('${electionsData.position!} Candidate'),
                              ),
                            ),
                            ...electionsData.candidate!.map((e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                                  child: ListTile(
                                    onTap: () {
                                      showDialog(context: context, builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          title: LottieBuilder.network('https://assets4.lottiefiles.com/packages/lf20_MtN0BG.json'),
                                          content: const Text('Are you sure, you want to vote?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () => Navigator.of(ctx).pop(),
                                                child: const Text('No')),
                                            TextButton(
                                                onPressed: (){
                                                  context.read<ElectionBloc>().add(
                                                    VoteSubmitted(
                                                      electionId: state.electionInfo!.id!,
                                                      context: context,
                                                      positionId: state.electionInfo!.elections![index].id!,
                                                      candidateId: e.id!,
                                                    ),
                                                  );
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: const Text('Yes')),
                                          ],
                                        );
                                      }, );
                                      // context.read<ElectionBloc>().add(
                                      //   VoteSubmitted(
                                      //     electionId: state.electionInfo!.id!,
                                      //     positionId: state.electionInfo!
                                      //         .elections![index].id!,
                                      //     candidateId: e.id!,
                                      //   ),
                                      // );

                                      print(
                                          "election_id ${state.electionInfo!.id!}");
                                      print(
                                          "position_id ${state.electionInfo!.elections![index].id!}");
                                      print("elected_id ${e.id!}");
                                    },
                                    leading:
                                        ClipOval(child: Image.network(e.avatar!)),
                                    title: Text(e.name!),
                                  ),
                                )),

                            // ...List.generate(
                            //   electionsData.candidate!.length,
                            //   (index) {
                            //     final candidateWithData = electionsData.candidate![index];
                            //     return Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //       child: ListTile(
                            //         onTap: () {
                            //           context.read<ElectionBloc>().add(
                            //             VoteSubmitted(
                            //               electionId: state.electionInfo!.id!,
                            //               positionId: state.electionInfo!.elections![index].id!,
                            //               candidateId: state.electionInfo!.elections![index].candidate![index].id!,
                            //             ),
                            //           );
                            //         },
                            //         leading: ClipOval(
                            //             child: Image.network(candidateWithData.avatar!)),
                            //         title: Text(candidateWithData.name!),
                            //         trailing: candidateWithData.isVote!
                            //             ? const Icon(
                            //           Icons.check_box,
                            //           color: Colors.green,
                            //         )
                            //             : const SizedBox(),
                            //       ),
                            //     );
                            //   },
                            // )

                            ///using radio button//============================
                            // ...List.generate(
                            //   electionsData.candidate!.length,
                            //       (i) {
                            //     // selectedPresidentList.addAll(electionsData.candidate!);
                            //
                            //     return RadioListTile<int>(
                            //       value: i,
                            //       title: Row(
                            //         children: [
                            //           Expanded(
                            //             child: Text(
                            //               electionsData.candidate![i].name ?? "",
                            //               style: const TextStyle(
                            //                   fontSize: 14,
                            //                   color: Colors.black,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ),
                            //           const Text(
                            //             'President',
                            //             style: TextStyle(
                            //                 fontSize: 14, fontWeight: FontWeight.w500),
                            //           ),
                            //         ],
                            //       ),
                            //       groupValue: selectedPresidentList[i][index],
                            //       onChanged: (value) {
                            //         // selectIndex = value!;
                            //         setState(() {
                            //           selectedPresidentList[i][index] = value!;
                            //           // selectIndex = value!;
                            //           // selectIndex = value!;
                            //         });
                            //
                            //         print('selectIndex ${selectedPresidentList[i][index]}');
                            //         print('Index $i');
                            //         print('value $value');
                            //         print('name ${state.electionInfo!.elections![index].candidate![value!].name}');
                            //         // selectPresidentType(value!);
                            //       },
                            //     );
                            //   },
                            // )
                          ],
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Column(
                          children: [
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                    '${electionsData.position!} Candidate'),
                              ),
                            ),
                            ...electionsData.candidate!.map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ListTile(
                                    leading: ClipOval(
                                        child: Image.network(e.avatar!)),
                                    title: Text(e.name!),
                                    // trailing: e.isVote!
                                    //     ? const Icon(
                                    //   Icons.check_box,
                                    //   color: Colors.green,
                                    // )
                                    //     : const SizedBox(),
                                  ),
                                )),

                            // ...List.generate(
                            //   electionsData.candidate!.length,
                            //   (index) {
                            //     final candidateWithData = electionsData.candidate![index];
                            //     return Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //       child: ListTile(
                            //         onTap: () {
                            //           context.read<ElectionBloc>().add(
                            //             VoteSubmitted(
                            //               electionId: state.electionInfo!.id!,
                            //               positionId: state.electionInfo!.elections![index].id!,
                            //               candidateId: state.electionInfo!.elections![index].candidate![index].id!,
                            //             ),
                            //           );
                            //         },
                            //         leading: ClipOval(
                            //             child: Image.network(candidateWithData.avatar!)),
                            //         title: Text(candidateWithData.name!),
                            //         trailing: candidateWithData.isVote!
                            //             ? const Icon(
                            //           Icons.check_box,
                            //           color: Colors.green,
                            //         )
                            //             : const SizedBox(),
                            //       ),
                            //     );
                            //   },
                            // )

                            ///using radio button//============================
                            // ...List.generate(
                            //   electionsData.candidate!.length,
                            //       (i) {
                            //     // selectedPresidentList.addAll(electionsData.candidate!);
                            //
                            //     return RadioListTile<int>(
                            //       value: i,
                            //       title: Row(
                            //         children: [
                            //           Expanded(
                            //             child: Text(
                            //               electionsData.candidate![i].name ?? "",
                            //               style: const TextStyle(
                            //                   fontSize: 14,
                            //                   color: Colors.black,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ),
                            //           const Text(
                            //             'President',
                            //             style: TextStyle(
                            //                 fontSize: 14, fontWeight: FontWeight.w500),
                            //           ),
                            //         ],
                            //       ),
                            //       groupValue: selectedPresidentList[i][index],
                            //       onChanged: (value) {
                            //         // selectIndex = value!;
                            //         setState(() {
                            //           selectedPresidentList[i][index] = value!;
                            //           // selectIndex = value!;
                            //           // selectIndex = value!;
                            //         });
                            //
                            //         print('selectIndex ${selectedPresidentList[i][index]}');
                            //         print('Index $i');
                            //         print('value $value');
                            //         print('name ${state.electionInfo!.elections![index].candidate![value!].name}');
                            //         // selectPresidentType(value!);
                            //       },
                            //     );
                            //   },
                            // )
                          ],
                        ),
                        Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: ClipRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50.withOpacity(0.1)),
                                  child: const Center(
                                    child: Icon(Icons.cloud_done_rounded,color:Colors.green,size: 75.0,)
                                  ),
                                ),
                              ),
                            ))
                      ],
                    );
            },
          );
        }
        return const SizedBox();
      }
      if (state.status == NetworkStatus.failure) {
        return const Center(
          child: Text('Error to load'),
        );
      }
      return const SizedBox();
    });
  }
}
