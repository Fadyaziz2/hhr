import 'package:cached_network_image/cached_network_image.dart';
import 'package:club_application/page/birthday/bloc/birthday_bloc.dart';
import 'package:club_application/res/const.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BirthdayContent extends StatelessWidget {
  const BirthdayContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthdayBloc, BirthdayState>(
      builder: (context, state) {
        if (state.status == NetworkStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: mainColor,
            ),
          );
        }
        if (state.status == NetworkStatus.success) {
          if (state.birthdays != null) {
            return state.birthdays!.data!.items!.isNotEmpty
                ? ListView.separated(
                    itemCount: state.birthdays!.data!.items!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = state.birthdays!.data!.items![index];
                      return data.isWished!
                          ? Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    child: Lottie.asset(
                                        'assets/lottie/lf20_pkanqwys.json'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(
                                            height: 80,
                                            width: 80,
                                            imageUrl: data.avatar ?? ''),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.name ?? '',
                                              style:
                                                  const TextStyle(height: 1.4),
                                            ),
                                            Text(data.birthday ?? '',
                                                style: const TextStyle(
                                                    height: 1.4, fontSize: 12)),
                                            const SizedBox(height: 4,),

                                            Text(data.message ?? '',
                                                style: const TextStyle(
                                                    height: 1.4, fontSize: 12)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                        height: 80,
                                        width: 80,
                                        imageUrl: data.avatar ?? ''),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.name ?? '',
                                          style: const TextStyle(height: 1.4),
                                        ),
                                        Text(data.birthday ?? '',
                                            style: const TextStyle(
                                                height: 1.4, fontSize: 12)),
                                        data.canWish!
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      // margin:
                                                      //     const EdgeInsets.only(top: 4, right: 8),
                                                      height: 40,
                                                      child: _WishInput(
                                                        name: data.name,
                                                      ),
                                                    ),
                                                  ),
                                                  WishSubmit(
                                                    wishId: data.id!,
                                                  )
                                                ],
                                              )
                                            : const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                child:
                                                    Text('Upcoming Birthday'),
                                              )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        endIndent: 12,
                        indent: 12,
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No Birthday Available',
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 1.6),
                    ),
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

class WishSubmit extends StatelessWidget {
  const WishSubmit({Key? key, required this.wishId}) : super(key: key);

  final int wishId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthdayBloc, BirthdayState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<BirthdayBloc>().add(WishSubmitted(wishId: wishId));
          },
          icon: const Icon(Icons.send),
        );
      },
    );
  }
}

class _WishInput extends StatelessWidget {
  const _WishInput({Key? key, this.name}) : super(key: key);

  final String? name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthdayBloc, BirthdayState>(
      buildWhen: (previous, current) =>
          previous.birthdayWish != current.birthdayWish,
      builder: (context, state) {
        return TextField(
          onChanged: (wish) => context
              .read<BirthdayBloc>()
              .add(BirthWishChanged(birthWish: wish)),
          decoration: InputDecoration(
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            // border: OutlineInputBorder(),
            hintText: 'Wish $name',
          ),
        );
      },
    );
  }
}
