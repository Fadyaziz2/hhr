import 'package:club_application/page/acts_regulation/view/acts_regulation_page.dart';
import 'package:club_application/page/anniversary/view/anniversary_page.dart';
import 'package:club_application/page/authentication/bloc/authentication_bloc.dart';
import 'package:club_application/page/birthday/view/birthday_page.dart';
import 'package:club_application/page/contact/contact.dart';
import 'package:club_application/page/directory/directory.dart';
import 'package:club_application/page/gallery/view/gallery_page.dart';
import 'package:club_application/page/more/view/more_page.dart';
import 'package:club_application/page/profile/profile.dart';
import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../donation/view/donation_page.dart';
import '../../../election/view/election_page.dart';
import '../../../event/view/event_page.dart';
import '../../../notice/view/notice_page.dart';
import '../../../pending_request/view/pending_request_page.dart';
import '../../models/home_item_model.dart';
import 'home_item.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final userGroup = context.read<AuthenticationBloc>().state.data?.user?.userGroup;
    final items = HomeItems.getHomeItems;
    final itemsWithPaddingList = HomeItems.getHomeItemsWithPaddingList;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 95.0,
            child: InkWell(
              onTap: null,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withOpacity(0.2),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Center(
                      child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/en/5/5a/Shaheen_College_Logo_Dhaka.png',
                        scale: 3,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${user?.user?.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(ProfileScreen.route(
                                  context
                                      .read<AuthenticationBloc>()
                                      .state
                                      .data
                                      ?.user
                                      ?.id));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "VIEW PROFILE",
                                style:
                                    TextStyle(fontSize: 14, color: mainColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                    'Are you sure, you want to logout'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<AuthenticationBloc>()
                                            .add(AuthenticationLogoutRequest());
                                      },
                                      child: const Text('Yes')),
                                ],
                              ),
                            ),
                        icon: const Icon(Icons.logout)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: userGroup == "management"
                    ? itemsWithPaddingList.length
                    : items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0),
                itemBuilder: (BuildContext context, int index) {
                  final data = userGroup == "management"
                      ? itemsWithPaddingList[index]
                      : items[index];
                  return HomeItem(
                      name: data.name,
                      icon: data.icon,
                      onPressed: () => homeNavigation(data.type, context));
                }),
          ),
        ],
      ),
    );
  }
}

void homeNavigation(ItemType type, BuildContext context) {
  switch (type) {
    case ItemType.gallery:
      Navigator.of(context).push(GalleryPage.route);
      break;
    case ItemType.birthday:
      Navigator.of(context).push(BirthdayPage.route);
      break;
    case ItemType.directory:
      Navigator.of(context).push(DirectoryPage.route);
      break;
    case ItemType.faculty:
      break;
    case ItemType.profile:
      Navigator.of(context).push(ProfileScreen.route(
          context.read<AuthenticationBloc>().state.data?.user?.id));
      break;
    case ItemType.donation:
      Navigator.of(context).push(DonationPage.route);
      break;
    case ItemType.contacts:
      Navigator.of(context).push(ContactPage.route);
      break;
    case ItemType.anniversary:
      Navigator.of(context).push(AnniversaryPage.route);
      break;
    case ItemType.event:
      Navigator.of(context).push(EventPage.route);
      break;
    case ItemType.notice:
      Navigator.of(context).push(NoticePage.route);
      break;
    case ItemType.ec:
      Navigator.of(context).push(ElectionPage.route);
      break;
    case ItemType.acts:
      Navigator.of(context).push(ActsRegulationPage.route);
      break;
    case ItemType.pendingRequest:
      Navigator.of(context).push(PaddingRequestPage.route);
      break;
    case ItemType.more:
      Navigator.of(context).push(MorePage.route);
      break;
    default:
      break;
  }
}
