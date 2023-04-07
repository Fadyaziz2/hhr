import 'package:club_application/page/authentication/bloc/authentication_bloc.dart';
import 'package:club_application/page/donation/bloc/donation_bloc.dart';
import 'package:club_application/res/const.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationContent extends StatelessWidget {
  const DonationContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationBloc, DonationState>(
      builder: (context, state) {
        if (state.status == NetworkStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: mainColor,
            ),
          );
        }

        if (state.status == NetworkStatus.success) {
          if (state.donationModel != null) {
            return ListView.builder(
              itemCount: state.donationModel!.data!.items!.length,
              itemBuilder: (BuildContext context, int index) {
                final data = state.donationModel!.data!.items![index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(data.attachmentFile!),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              Text(
                                data.title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, height: 1.4),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 4,
                                    children: [
                                      Image.asset(
                                        'assets/donation_icon/people_icon.png',
                                        height: 16,
                                        width: 16,
                                      ),
                                      Text(
                                        '${data.donors!}',
                                        style: const TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 4,
                                    children:  [
                                      Image.asset(
                                        'assets/donation_icon/like_icon.png',
                                        height: 16,
                                      ),
                                      Text(
                                        '${data.appreciate}',
                                        style: const TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 4,
                                    children: [
                                       Image.asset(
                                        'assets/donation_icon/money.png',
                                        height: 16,
                                      ),
                                      Text(
                                        '${data.totalAmount}',
                                        style: const TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 4,
                                    children: [
                                      Image.asset(
                                        'assets/donation_icon/date_icon.png',
                                        height: 16,
                                      ),
                                      Text(
                                        '${data.startDate} - ${data.endDate}',
                                        style: const TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () => debugPrint('press'),
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFFF68744)),
                                      child: const Text('Donate'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color(0xFF926DFF)
                                      ),
                                        onPressed: (){
                                          final user = context.read<AuthenticationBloc>().state.data;
                                          context.read<DonationBloc>().add(DonationAppreciateSubmitted(donationId: data.id!, userId: user!.user!.id!));
                                        },
                                        child: const Text('Appreciate')),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        )
                      ]),
                );
              },
            );
          }
        }

        if (state.status == NetworkStatus.failure) {
          return const Center(
            child: Text('Error to load'),
          );
        }
        return const SizedBox();
      },
    );
  }
}
