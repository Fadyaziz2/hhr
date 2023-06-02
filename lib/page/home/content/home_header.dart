import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/const.dart';
import '../models/event_model.dart';
import 'event_card.dart';

class HomeHeader extends StatelessWidget {

  final Settings? settings;
  final LoginData? user;

  const HomeHeader({Key? key,required this.settings,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          left: 0,
          child: Image.asset(
            'assets/images/home_background_one.png',
            fit: BoxFit.cover,
            color: colorPrimary,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const SizedBox(height: 40.0,),
            Row(
              children: [
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 8),
                        child: Text(
                          settings?.data?.timeWish?.wish?? "",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child:Text(
                          '${user?.user?.name}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight:
                              FontWeight.bold,
                              height: 1.5,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 8.0),
                        child: Text(
                          settings?.data?.timeWish?.subTitle?? "",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w400,
                              height: 1.5,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.network(
                  settings?.data?.timeWish?.image ?? "",
                  semanticsLabel: 'sun',
                  height: 60,
                  width: 60,
                  placeholderBuilder:
                      (BuildContext context) =>
                  const SizedBox(),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(height: 16.0,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Today summary',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: Colors.white,
                    letterSpacing: 0.5),
              ),
            ),
            const SizedBox(height: 8.0,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                  children: List.generate(
                    5, (index) => EventCard(
                    data: Today(image: 'https://upload.wikimedia.org/wikipedia/en/5/5a/Shaheen_College_Logo_Dhaka.png',title: 'Leave',number: 21),
                    onPressed: () => null,
                  ),
                  )),
            ),
            // SizedBox(
            //   height: 95.0,
            //   child: InkWell(
            //     onTap: null,
            //     child: Container(
            //       margin:
            //       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            //       padding: const EdgeInsets.all(8.0),
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         shape: BoxShape.rectangle,
            //         boxShadow: [
            //           BoxShadow(
            //             color: mainColor.withOpacity(0.2),
            //             blurRadius: 4.0,
            //             spreadRadius: 1.0,
            //           )
            //         ],
            //       ),
            //       child: Row(
            //         children: [
            //           Center(
            //             child: Image.network(
            //               'https://upload.wikimedia.org/wikipedia/en/5/5a/Shaheen_College_Logo_Dhaka.png',
            //               scale: 3,
            //             ),
            //           ),
            //           const SizedBox(
            //             width: 16,
            //           ),
            //           Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text('${user?.user?.name}',
            //                     maxLines: 1,
            //                     overflow: TextOverflow.ellipsis,
            //                     style: const TextStyle(
            //                         fontWeight: FontWeight.bold, fontSize: 16)),
            //                 InkWell(
            //                   onTap: () {
            //                     Navigator.of(context).push(ProfileScreen.route(
            //                         context
            //                             .read<AuthenticationBloc>()
            //                             .state
            //                             .data
            //                             ?.user
            //                             ?.id,settings));
            //                   },
            //                   child: Padding(
            //                     padding:
            //                     const EdgeInsets.symmetric(vertical: 5.0),
            //                     child: Text(
            //                       "VIEW PROFILE",
            //                       style:
            //                       TextStyle(fontSize: 14, color: mainColor),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           IconButton(
            //               onPressed: () => showDialog(
            //                 context: context,
            //                 builder: (context) => AlertDialog(
            //                   content: const Text(
            //                       'Are you sure, you want to logout'),
            //                   actions: [
            //                     TextButton(
            //                         onPressed: () =>
            //                             Navigator.of(context).pop(),
            //                         child: const Text('No')),
            //                     TextButton(
            //                         onPressed: () {
            //                           context
            //                               .read<AuthenticationBloc>()
            //                               .add(AuthenticationLogoutRequest());
            //                         },
            //                         child: const Text('Yes')),
            //                   ],
            //                 ),
            //               ),
            //               icon: const Icon(Icons.logout)),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
